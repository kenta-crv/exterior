// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require_tree .


// jsを再読み込みさせたいページで使う（/companies/pay）
$(document).on("turbolinks:load", function () {
  let path_name = location.pathname;
  let path_search = location.search;
  if (path_search == '?reload=true') {
    window.location.href = path_name
  }
})

// カーソルにモーダルを表示する処理
document.querySelectorAll('td.hoverable').forEach(function(element) {
  element.addEventListener('mouseover', function() {
    var comment = this.getAttribute('data-comment');
    if (comment) {
      var popup = document.createElement('div');
      popup.className = 'hoverable-popup';
      popup.innerHTML = comment;
      document.body.appendChild(popup);
      
      // カーソルに近い位置にモーダルを表示
      popup.style.left = (event.clientX + 10) + 'px';
      popup.style.top = (event.clientY + 10) + 'px';
      
      // モーダルを表示
      popup.style.display = 'block';

      // カーソルから外れたらモーダルを非表示にする
      element.addEventListener('mouseout', function() {
        document.body.removeChild(popup);
      });
    }
  });
});




document.addEventListener("DOMContentLoaded", () => {
  const wrapper = document.querySelector(".row-slider .slider-wrapper");
  const nextBtn = document.querySelector(".row-slider .next-btn");
  const blocks = document.querySelectorAll(".row-slider .block");
  let index = 0;

  const isMobile = () => window.innerWidth <= 599;

  nextBtn.addEventListener("click", () => {
    if (!isMobile()) return;

    index = Math.min(index + 1, blocks.length - 1);
    wrapper.style.transform = `translateX(-${index * 100}%)`;
    wrapper.style.transition = "transform 0.5s ease";
  });

  window.addEventListener("resize", () => {
    if (!isMobile()) {
      wrapper.style.transform = "none";
      wrapper.style.transition = "none";
      index = 0;
    }
  });
});
