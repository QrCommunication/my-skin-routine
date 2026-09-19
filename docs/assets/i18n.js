(function () {
  "use strict";

  var SHARED = {
    en: {
      "nav.features": "Features", "nav.how": "How it works", "nav.privacy": "Privacy",
      "nav.legal": "Legal", "nav.terms": "Terms", "nav.privacyPage": "Privacy policy",
      "nav.legalPage": "Legal notice", "nav.back": "Back to home",
      "footer.tag": "A calm, private skincare tracker. Built offline-first for Android.",
      "footer.product": "Product", "footer.legal": "Legal", "footer.get": "Get the app",
      "footer.faq": "FAQ", "footer.download": "Download APK", "footer.play": "Google Play",
      "footer.terms": "Terms of use", "footer.privacy": "Privacy policy", "footer.legalPage": "Legal notice",
      "footer.rights": "All rights reserved.", "footer.disclaimer": "My Skin Routine is a wellness tracker. It is not a medical device and does not provide medical advice.",
      "footer.editor": "Published by QR Communication SAS · Paris"
    },
    fr: {
      "nav.features": "Fonctionnalités", "nav.how": "Comment ça marche", "nav.privacy": "Confidentialité",
      "nav.legal": "Mentions légales", "nav.terms": "CGU", "nav.privacyPage": "Confidentialité",
      "nav.legalPage": "Mentions légales", "nav.back": "Retour à l'accueil",
      "footer.tag": "Un tracker skincare apaisé et privé. Conçu offline-first pour Android.",
      "footer.product": "Produit", "footer.legal": "Légal", "footer.get": "Obtenir l'app",
      "footer.faq": "FAQ", "footer.download": "Télécharger l'APK", "footer.play": "Google Play",
      "footer.terms": "Conditions d'utilisation", "footer.privacy": "Politique de confidentialité", "footer.legalPage": "Mentions légales",
      "footer.rights": "Tous droits réservés.", "footer.disclaimer": "My Skin Routine est un outil de bien-être. Ce n'est pas un dispositif médical et l'app ne délivre aucun conseil médical.",
      "footer.editor": "Édité par QR Communication SAS · Paris"
    }
  };

  function dict() {
    var lang = current;
    var base = SHARED[lang] || {};
    var page = (window.PAGE_DICT && window.PAGE_DICT[lang]) || {};
    return Object.assign({}, base, page);
  }

  function apply(lang) {
    current = lang;
    try { localStorage.setItem("msr-lang", lang); } catch (e) {}
    var d = dict();
    document.querySelectorAll("[data-i18n]").forEach(function (el) {
      var k = el.getAttribute("data-i18n");
      if (d[k] !== undefined) el.innerHTML = d[k];
    });
    document.documentElement.lang = lang;
    if (d["meta.title"]) document.title = d["meta.title"];
    var on = document.getElementById("lang-en"), off = document.getElementById("lang-fr");
    if (on) on.classList.toggle("on", lang === "en");
    if (off) off.classList.toggle("on", lang === "fr");
  }

  window.setLang = function (lang) { apply(lang); };

  var saved = null;
  try { saved = localStorage.getItem("msr-lang"); } catch (e) {}
  current = saved || ((navigator.language || "en").toLowerCase().indexOf("fr") === 0 ? "fr" : "en");

  function init() {
    apply(current);
    var btn = document.getElementById("lang-en"), bfr = document.getElementById("lang-fr");
    if (btn) btn.addEventListener("click", function () { setLang("en"); });
    if (bfr) bfr.addEventListener("click", function () { setLang("fr"); });

    var nav = document.querySelector(".nav");
    if (nav) {
      var onScroll = function () { nav.classList.toggle("scrolled", window.scrollY > 24); };
      window.addEventListener("scroll", onScroll, { passive: true });
      onScroll();
    }

    if ("IntersectionObserver" in window) {
      var io = new IntersectionObserver(function (entries) {
        entries.forEach(function (e) {
          if (e.isIntersecting) { e.target.classList.add("in"); io.unobserve(e.target); }
        });
      }, { threshold: 0.12 });
      document.querySelectorAll("[data-reveal]").forEach(function (el) { io.observe(el); });
    } else {
      document.querySelectorAll("[data-reveal]").forEach(function (el) { el.classList.add("in"); });
    }
  }

  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", init);
  else init();
})();
