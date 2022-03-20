import { icHomeword } from "../../declarations/icHomeword";
import { timeSince } from './utils'
import { Principal } from "@dfinity/principal";
document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();
  const button = e.target.querySelector("#post");
  const textarea = document.querySelector("#message")
  const msg = textarea.value.toString();

  button.setAttribute("disabled", true);
  try {
    const post = await icHomeword.post(msg, '123123');
    await getPosts();
    button.removeAttribute("disabled");
    textarea.value = ''
    return false;
  } catch (err) {
    console.error(err)
  }

});
async function getName() {
  const author = await icHomeword.get_name()
  document.querySelector('#author').innerHTML = author
}

async function setName() {
  const name = document.querySelector('#authorName').value
  try {
    await icHomeword.set_name(name, '123123')
    await getName()
  } catch (err) {
    console.error(err)
  }
}

async function getPosts(pid, postList) {
  console.log(pid)
  let posts = []
  if (pid) {
    posts = await icHomeword.postsById(pid)
  } else {
    posts = await icHomeword.posts()
  }
  const section = document.querySelector('#section');
  const arr = posts.map(v => {
    const timeInSeconds = Math.floor(Number(v.time) / 1000000);
    // const date = new Date(timeInSeconds);
    const dateFormatted = timeSince(timeInSeconds)
    // const dateFormatted = `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`;
    return `
    <div class="card-body">
      <h2 class="card-title">${v.author}</h2>
      <p class="flex justify-between">${v.text}<span>${dateFormatted}</span></p>
    </div>
    `
  })
  // if (postList) {
  //   postList.innerHTML = arr.join('')
  // }
  if (postList) {
    postList.innerHTML = arr.join('')
  } else {
    section.innerHTML = arr.join('')
  }
}

async function setFollow() {
  const pid = document.querySelector('#pid')
  try {
    if (pid.value.trim() === '') {
      alert ('please input principalId')
      return false
    }
    await icHomeword.follow(Principal.fromText(pid.value.trim()))
    pid.vlaue = ''
    tabs[2].click()
  } catch (err) {
    console.error(err)
    alert(err)
  }
  
}

let tabs = []
async function setUnfollow(id) {
  await icHomeword.unfollow(id)
  getFollowed()
}

async function getFollowed() {
  const follows = await icHomeword.follows()
  const section = document.querySelector('#section');
  const arr = follows.map((v, i) => {
    return `
    <tr>
      <th>${i + 1}</th>
      <td><a class="to cursor-pointer hover:text-lime-400">${v.name}</a></td>
      <td>${v.id}</td>
      <td><a class="unfollow" href="#">unfollow</a></td>
    </tr>
    `
  })
  const table = `
  <table class="table w-full">
  <thead>
    <tr>
      <th></th>
      <th>Name</th>
      <th>Principal ID</th>
      <th>action</th>
    </tr>
  </thead>
  <tbody id="followTable">
    ${arr.join('')}
    </tbody>
</table>
  `
  section.innerHTML = table
  const followTable = document.querySelector('#followTable')
  const nameItems = followTable.querySelectorAll('.to')
  const unfollowItems = followTable.querySelectorAll('.unfollow')
  let postsList = document.querySelector('#postsList')
  if (!postsList) {
    console.log(123)
    postsList = document.createElement('div')
    postsList.id = 'postsList'
    section.appendChild(postsList)
  }
  nameItems.forEach((v, i) => {
    v.onclick = function () {getPosts(follows[i].id, postsList)}
  })

  unfollowItems.forEach((v, i) => {
    v.onclick = function () {setUnfollow(follows[i].id)}
  })
}

async function getTimeLine() {
  const posts = await icHomeword.timeline()
  const section = document.querySelector('#section');
  const arr = posts.map(v => {
    const timeInSeconds = Math.floor(Number(v.time) / 1000000);
    // const date = new Date(timeInSeconds);
    const dateFormatted = timeSince(timeInSeconds)
    // const dateFormatted = `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`;
    return `
    <div class="card-body">
      <h2 class="card-title">${v.author}</h2>
      <p class="flex justify-between">${v.text}<span>${dateFormatted}</span></p>
    </div>
    `
  })
  section.innerHTML = arr.join('')
}

let tabIndex = 0
const events = [getPosts, getTimeLine, getFollowed]
function tabsInit() {
  tabs = document.querySelectorAll('#tabs a')
  tabs[0].classList.add('tab-active')
  tabs.forEach((v, i) => {
    v.onclick = () => {
      tabs[tabIndex].classList.remove('tab-active')
      tabIndex = i
      tabs[tabIndex].classList.add('tab-active')
      events[i]()
    }
  })
}

function load() {
  document.querySelector('#ok').onclick = setName
  document.querySelector('#addFollow').onclick = setFollow
  getName()
  getPosts()
  tabsInit()
}

window.onload = load;
// const qsort = arr => (arr.length > 1 ? (([h, ...t]) => [].concat(qsort(t.filter(x => x <= h)),[h],qsort(t.filter(x => x > h))))(arr) : arr);
