/* My Skin Routine — text scramble composer
   Letters appear shuffled, then lock left-to-right into the final text.
   ScrollTrigger: composes on the way down, dissolves on the way up.
   Re-syncs itself after every language switch (msr:lang event). */
(function () {
  "use strict";

  var GLYPHS = "!<>-_\\/[]{}=+*^?#%&@$~abcdefghijklmnopqrstuvwxyz";
  var targets = [];

  function prepare(el) {
    if (el.dataset.scReady === "1") return;
    el.querySelectorAll(".sc").forEach(function (s) {
      s.replaceWith(document.createTextNode(s.getAttribute("data-ch") || s.textContent));
    });
    if (!el.dataset.finalHtml) el.dataset.finalHtml = el.innerHTML;
    (function walk(node) {
      [].slice.call(node.childNodes).forEach(function (child) {
        if (child.nodeType === 3) {
          var frag = document.createDocumentFragment();
          child.textContent.split("").forEach(function (c) {
            var s = document.createElement("span");
            s.className = "sc";
            s.setAttribute("data-ch", c);
            s.textContent = c;
            frag.appendChild(s);
          });
          node.replaceChild(frag, child);
        } else if (child.nodeType === 1 && child.tagName !== "BR") {
          walk(child);
        }
      });
    })(el);
    el.dataset.scReady = "1";
  }

  function dissolve(el) {
    if (el._scTimer) { clearInterval(el._scTimer); el._scTimer = null; }
    if (el.dataset.finalHtml) {
      el.innerHTML = el.dataset.finalHtml;
      el.dataset.scReady = "";
    }
  }

  function play(el, duration, delay) {
    prepare(el);
    var spans = [].slice.call(el.querySelectorAll(".sc"));
    if (!spans.length) return;
    if (el._scTimer) clearInterval(el._scTimer);
    var total = (duration || 1.5) * 1000;
    var start = performance.now() + (delay || 0) * 1000;
    var locks = spans.map(function (_, i) {
      return start + (i / spans.length) * total * 0.68 + Math.random() * total * 0.26;
    });
    var last = 0;
    el._scTimer = setInterval(function () {
      var now = performance.now();
      var done = true;
      if (now - last > 30) {
        last = now;
        spans.forEach(function (s, i) {
          if (now < locks[i]) {
            done = false;
            s.textContent = GLYPHS.charAt(Math.floor(Math.random() * GLYPHS.length));
            s.style.opacity = 0.5;
          }
        });
      } else {
        spans.forEach(function (s, i) { if (now < locks[i]) done = false; });
      }
      if (done) {
        spans.forEach(function (s, i) { s.textContent = s.getAttribute("data-ch"); s.style.opacity = 1; });
        clearInterval(el._scTimer);
        el._scTimer = null;
      }
    }, 30);
  }

  function inView(el) {
    var r = el.getBoundingClientRect();
    return r.top < window.innerHeight * 0.85 && r.bottom > 0;
  }

  function bind(selector, opts) {
    opts = opts || {};
    [].slice.call(document.querySelectorAll(selector)).forEach(function (el) {
      if (targets.some(function (t) { return t.el === el; })) return;
      targets.push({ el: el, duration: opts.duration || 1.4, start: opts.start || "top 82%" });
    });
  }

  function setup() {
    if (typeof gsap === "undefined" || typeof ScrollTrigger === "undefined") return;
    gsap.registerPlugin(ScrollTrigger);
    targets.forEach(function (t) {
      ScrollTrigger.create({
        trigger: t.el,
        start: t.start,
        onEnter: function () { play(t.el, t.duration); },
        onEnterBack: function () { play(t.el, t.duration); },
        onLeaveBack: function () { dissolve(t.el); }
      });
    });
  }

  function onLang() {
    targets.forEach(function (t) {
      if (t.el._scTimer) { clearInterval(t.el._scTimer); t.el._scTimer = null; }
      t.el.dataset.finalHtml = t.el.innerHTML;
      t.el.dataset.scReady = "";
    });
    targets.forEach(function (t) {
      if (inView(t.el)) play(t.el, t.duration, 0.1);
    });
    if (typeof ScrollTrigger !== "undefined") ScrollTrigger.refresh();
  }

  window.MSRScramble = { bind: bind, setup: setup, onLang: onLang, play: play, dissolve: dissolve };

  document.addEventListener("msr:lang", onLang);

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", setup);
  else setup();
})();
