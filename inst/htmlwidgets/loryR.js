HTMLWidgets.widget({

  name: 'loryR',

  type: 'output',

  initialize: function(el, width, height) {

    return {  }

  },

  renderValue: function(el, x, instance) {
    // el.removeAttribute("style")

    if(x.images){
      var len = x.images.length,
          i = 0;
      for( ; i < len; i++ ){
        var img = document.createElement("img")
        img.src = x.images[i];
        // try to smartly size images based on slides_per_page if provided
        if(!(x.images_per_page === null)){
          img.style.width = el.getBoundingClientRect().width / x.images_per_page + "px";
          img.style.height = el.getBoundingClientRect().height + "px";
        }
        var liEl = document.createElement("li")
        liEl.className = "js_slide"
        liEl.appendChild(img)
        el.getElementsByClassName("slides")[0].appendChild(liEl);
      }
    }

    lory( el, x.options )

  },

  resize: function(el, width, height, instance) {

  }

});
