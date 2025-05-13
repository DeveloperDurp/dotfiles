// ==UserScript==
// @name Privacy Redirector
// @description	Redirect social media platforms to their privacy respecting frontends
// @namespace https://github.com/dybdeskarphet/privacy-redirector
// @author Ahmet Arda Kavakcı
// @license GPLv3
// @version 1.6.2
// @run-at document-start
// @match *://*.bandcamp.com/*
// @match *://*.fandom.com/*
// @match *://*.genius.com/*
// @match *://*.google.com/*
// @match *://*.imdb.com/*
// @match *://*.imgur.com/*
// @match *://*.imgur.io/*
// @match *://*.instagram.com/*
// @match *://*.medium.com/*
// @match *://*.pinterest.com/*
// @match *://*.quora.com/*
// @match *://*.reddit.com/*
// @match *://*.reuters.com/*
// @match *://*.soundcloud.com/*
// @match *://*.tiktok.com/*
// @match *://*.twitch.tv/*
// @match *://*.deepl.com/*
// @match *://*.deviantart.com/*
// @match *://twitch.tv/*
// @match *://*.twitter.com/*
// @match *://*.x.com/*
// @match *://*.tumblr.com/*
// @match *://x.com/*
// @match *://*.wikipedia.org/*
// @match *://*.youtube-nocookie.com/*
// @match *://*.youtube.com/*
// @match *://f4.bcbits.com/*
// @match *://genius.com/*
// @match *://i.pinimg.com/*
// @match *://imgur.com/*
// @match *://instagram.com/*
// @match *://medium.com/*
// @match *://news.ycombinator.com/*
// @match *://reddit.com/*
// @match *://stackoverflow.com/*
// @match *://t4.bcbits.com/*
// @match *://translate.google.com/*
// @match *://twitter.com/*
// @match *://www.goodreads.com/*
// @match *://www.pixiv.net/*
// @match *://youtube.com/*
// @exclude *://*.youtube.com/redirect*
// @exclude *://youtube.com/redirect*
// @downloadURL https://update.greasyfork.org/scripts/436359/Privacy%20Redirector.user.js
// @updateURL https://update.greasyfork.org/scripts/436359/Privacy%20Redirector.meta.js
// ==/UserScript==

/*
  ___  _   _        ___  _____ _____
 / _ \| \ | |      / _ \|  ___|  ___|
| | | |  \| |_____| | | | |_  | |_
| |_| | |\  |_____| |_| |  _| |  _|
 \___/|_| \_|      \___/|_|   |_|

CHANGE THE RELEVANT VALUE TO "false" TO
DISABLE THE REDIRECTION/FARSIDE FOR THAT
PARTICULAR PLATFORM */

//original script https://greasyfork.org/scripts/436359-privacy-redirector/code/Privacy%20Redirector.user.js

//           REDIRECTON / FARSIDE

let reddit = [true, false];
let youtube = [false, false];

// PREFERRED FRONTEND
let youtubeFrontend = "invidious"; // accepts "invidious", "piped", "tubo", "freetube"
let redditFrontend = "libreddit"; // accepts "libreddit", "teddit"

/*
 ___           _
|_ _|_ __  ___| |_ __ _ _ __   ___ ___  ___
 | || '_ \/ __| __/ _` | '_ \ / __/ _ \/ __|
 | || | | \__ \ || (_| | | | | (_|  __/\__ \
|___|_| |_|___/\__\__,_|_| |_|\___\___||___/

LIST OF INSTANCES TO USE IF FARSIDE IS NOT ENABLED
*/

const Instances = {
  invidious: [
    "invidious.durp.info"
  ],
  libreddit: [
    "redlib.durp.info",
  ],
};

const hash = window.location.hash,
  scheme = `https://`;

let debug_mode = false;

if (debug_mode) {
  alert(
    "\n== DEBUG MODE IS ON ==" +
    "\nIf you're seeing this" +
    "\nset the debug_mode value to" +
    "\nfalse for Privacy Redirector." +
    "\n======================" +
    "\n\nHostname: " +
    window.location.hostname +
    "\nPath: " +
    window.location.pathname +
    "\nQuery: " +
    window.location.search +
    "\nHash: " +
    hash,
  );
}

let selectedInstance = "",
  newURL = "";

const getrandom = async (instances) =>
  instances[Math.floor(Math.random() * instances.length)];


async function redirectReddit() {
  if (reddit[0] && !window.location.pathname.startsWith("/domain")) {
    window.stop();
    let pathname = window.location.pathname;
    let search = window.location.search;

    selectedInstance = reddit[1]
      ? `${farsideInstance}/${redditFrontend}`
      : await getrandom(Instances[redditFrontend]);

    if (pathname === "/media" && search) {
      const params = new URLSearchParams(search);
      const mediaURL = new URL(params.get("url"));
      if (["i.redd.it", "preview.redd.it"].includes(mediaURL.hostname)) {
        pathname = `/img${mediaURL.pathname}`;
        search = mediaURL.search;
      }
    }
    newURL = `${scheme}${selectedInstance}${pathname}${search}${hash}`;

    window.location.replace(newURL);
  }
}

async function redirectYoutube(frontend) {
  if (youtube[0]) {
    window.stop();
    let searchpath = `${window.location.pathname}${window.location.search}`;
    if (window.location.pathname.startsWith("/embed")) {
      selectedInstance = youtube[1]
        ? `${farsideInstance}/invidious`
        : await getrandom(Instances["invidious"]);
      newURL = `${scheme}${selectedInstance}${window.location.pathname}${window.location.search
        }${hash}`;
      window.location.replace(newURL);
    } else {
      if (frontend === "tubo") {
        selectedInstance = await getrandom(Instances.tubo);

        searchpath = `/stream?url=${window.location.href}`;
        if (
          window.location.pathname.startsWith("/@") ||
          window.location.pathname.startsWith("/channel")
        )
          searchpath = `/channel?url=${window.location.href}`;
      } else if (frontend === "freetube") {
        let youtube_link = window.location.href;
        window.location.replace(`freetube://${youtube_link}`);
        return;
      } else {
        selectedInstance =
          youtube[1] && frontend !== "hyperpipe"
            ? `${farsideInstance}/${frontend}`
            : await getrandom(Instances[frontend]);
      }

      newURL = `${scheme}${selectedInstance}${searchpath}${hash}`;
      window.location.replace(newURL);
    }
  }
}

const urlHostname = window.location.hostname;

switch (urlHostname) {
  case "www.youtube.com":
  case "m.youtube.com":
  case "www.youtube-nocookie.com":
    redirectYoutube(youtubeFrontend);
    break;

  case urlHostname.includes("reddit.com") ? urlHostname : 0:
    redirectReddit();
    break;
}

// export module for the test in github action
typeof module !== "undefined"
  ? (module.exports = { Instances: Instances })
  : true;
