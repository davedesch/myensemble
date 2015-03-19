// the document ready that launches everything.

var ready = function(){

  console.log('working!');
  displayAllOutfits();
  displayRecentOutfits();
  displayTrendingHashtags();
  newOutfit();
  bindEvents();

}
// FIND A BETTER WAY TO TRIGGER THIS SO IT DOESN'T CAUSE EVERYTHING TO REFRESH WHEN YOU DO AN AJAX CALL
$(document).ready(ready);
$(document).on('page:load', ready)


function newRatingStarsHover(){

  $("form .new-rating-stars").mouseenter(function(event){
    var hoveredStarId = event.currentTarget.id
    var parentId = event.currentTarget.parentElement.id
    $("#"+ parentId + " #"+ hoveredStarId +"").css('background', "url('../star-full.png')");
    $("#"+parentId + " #"+ hoveredStarId +"").prevAll().css('background', "url('../star-full.png')");
  });

  $("form .new-rating-stars").mouseleave(function(event){
    var hoveredStarId = event.currentTarget.id
    var parentId = event.currentTarget.parentElement.id
    $("#"+parentId + " #"+ hoveredStarId +"").css('background', "url('../star-empty.png')");
    $("#"+parentId + " #"+ hoveredStarId +"").prevAll().css('background', "url('../star-empty.png')");
  });
}

// POPULATES A HIDDEN VALUE IN FORM THAT WILL LATER UPDATE AR IN POST ROUTE.
function newRatingStarsClick(){
  $('.new-rating-stars').on('click', function(event){
    console.log('clicked on a star')
    var parentId = event.currentTarget.parentElement.id
    $("#"+parentId+" .new-rating-stars").off("mouseenter")
    $("#"+parentId+" .new-rating-stars").off("mouseleave")
    $("#"+parentId+" .new-rating-stars").css('background', "url('../star-empty.png')")

    var starNumber = event.currentTarget.id.substring(4)
    var thisOutfitsRatingForm = $(this).parent()[0]
    var outfitIndex = thisOutfitsRatingForm.id.substring(10)
    $("#newrating-" + outfitIndex + " div:lt("+ starNumber +")").css('background', "url('../star-full.png')")
    $("#form-" + outfitIndex)[0][0].value = starNumber
  })
}

function bindEvents(){
  // $('.img-thumbnail').on('click', function(event) {
  //   var imgURL = this.src
  //   selectInstagramImage(imgURL);
  // });
  // $('#get_from_instagram').on('click', function(event) {
  //   event.preventDefault();
  //   $.ajax({
  //     url: '/instagram/recent',
  //     type: 'GET',
  //     dataType: 'html',
  //   })
  //   .done(function(response) {
  //     $('#instagram_select').html(response)
  //   });
  // });
  $('#search-form').on('submit', function(event){
    event.preventDefault();
    displaySearchedOutfits();
  })
   $('#sort-by-ratings').on('click', function(){
    sortByRatings();
   });
   $('#sort-by-popularity').on('click', function(){
    sortByPopularity();
   });
   $('#sort-by-recent').on('click', function(){
    sortByRecent();
   });



};

//Instagram functions
function selectInstagramImage(imgURL){
  $('#outfit_image_url').val(imgURL);
  $('#newoutfitthumbnail').append("<img src="+ imgURL +">")
  $('#instagram_select').empty();
};


// When you search for something it displays all outfits that correllate with hashtag
function displaySearchedOutfits(event) {
  $.ajax({
    url: '/search',
    data: {hashtag: $('#search-box')[0].value},
  })
  .done(function(data) {
    renderFeed(data);
  })
}

// SETS AVERAGE RATING FOR EACH OUTFIT ON FEED. DATA COMES FROM WHATEVER AJAX CALL POPULATES THE FEED.
function addAverageRating(data) {
 for (var i = 0; i < data.length ; i++ ) {
  var rating = data[i].avg_rating
  if (rating > 0) {
    $("#rating-" + i + " div:lt("+ rating +")").css('background', "url('../star-full.png')")
  }
}
}

// Home Feed
function displayAllOutfits(){
  console.log('it happened')
  $.ajax({
    url: "/ensembles"
  }).done(function(data){
    renderFeed(data);
  })
}

// IN PROGRESS. CURRENTLY RETURNS AN ARRAY SORTED HIGHEST TO LOWEST WITHOUT CORRESPONDING VALUES

// WAITS FOR RATING BUTTON TO BE CLICKED
// SEE IF ALL LISTENERS CAN BE MOVED TO LISTENER MODULE
function addRatingListener() {
  $('.rate-this-button').on('click', function(event) {
    $(this).next('.rating-form').css('display', 'block');

  })
}



// SELF EXPLANATORY. ANYTHING THAT JUST GOT ADDED GETS PUT TO THE TOP OF THE FEED.
// THIS DISPLAYS ON THE WIDGET ON THE LEFT
function displayRecentOutfits (){
  var source = $("#recent-outfits-template").html();
  var template =Handlebars.compile(source);
  var context = {};

  $.ajax({
    url: window.location.pathname + "/ensembles"
  }).done(function(data){
    context = {recentOutfits: data};
    $('#recent-outfits').html(template(context));
      updateOutfit();
  })
}

// THE WIDGET THAT DISPLAYS ALL HASHTAGS ON THE RIGHT SIDE OF THE SCREEN. RENAME TO WIDGET SOON.
function displayTrendingHashtags (){
  var source = $("#trending-hashtags-template").html();
  var template = Handlebars.compile(source);
  var context = {};

  $.ajax({
    url: "/hashtags"
  }).done(function(data){
    context = {trendingHashtags: data};
    $('#trending-hashtags').html(template(context));
    $('.hashtag-link').on('click', function(event){
      event.preventDefault();
      displayHashtagOutfits(event);
    })
  })
}

// THIS IS THE SAME AS DISPLAY ALL OUTFITS AND WE CAN PROBABLY BURN IT.
function displayHashtagOutfits(event) {
  $.ajax({
    url: event.currentTarget.href,
  })
  .done(function(data) {
    renderFeed(data);
  })
}

function updateOutfit() {
  $('.update-button').on("click", function(event){
    event.preventDefault();
  var outfitNumber = event.currentTarget.id.substring(7);
  url = window.location.pathname + '/ensembles/' + outfitNumber + '/edit'
  $.ajax({
    url: url,
    dataType: "HTML"
  })
  .done(function(data) {
    $('#all-outfits').html(data);
  })
  });
}

// POST ROUTE THAT ENABLES CLOUDINARY AND PREPENDS PICTURE AND DATA TO TOP OF FEED
function newOutfit() {
  $('#newoutfit').on("click", function(event){
    console.log('clicked!');
    event.preventDefault();
    $.ajax({
      url: window.location.pathname+'/ensembles/new',
      type: 'GET',
      dataType: 'HTML',
      // data: {param1: 'value1'},
    })
    .done(function(a) {
      // console.log("success");
      $('#all-outfits').html(a);
        $('#get_from_instagram').on('click', function(event) {
    event.preventDefault();
    $.ajax({
      url: '/instagram/recent',
      type: 'GET',
      dataType: 'html',
    })
    .done(function(response) {
      $('#instagram_select').html(response);
       $('.img-thumbnail').on('click', function(event) {
    var imgURL = this.src
    selectInstagramImage(imgURL);
  });
    });
  });
      uploadImage();
    })
  });
}
// MOSTLY VANILLA JS TO BRING UP CLOUDINARY WIDGET. RENAME MAGIC SOON.
var magic = null
function uploadImage() {
 document.getElementById("upload_widget_opener").addEventListener("click", function() {

  cloudinary.openUploadWidget({ cloud_name: 'dzxyyevk0', upload_preset: 'iiv6os2n', max_files: 1, cropping_aspect_ratio: 1, },
    function(error, result) { console.log(error, result)
      magic = result;
      console.log('still working');
      console.log(magic)
      var imgURL = magic[0].secure_url;
      $('#outfit_image_url').val(imgURL);
      $('#newoutfitthumbnail').append("<img src="+ imgURL +">");
    });

}, false);

}


function sortByRatings() {
  var sortedOutfits = currentFeed.sort(function(a,b){
  return b.avg_rating - a.avg_rating
  });
  renderFeed(sortedOutfits);
}

function sortByPopularity() {
  var sortedOutfits = currentFeed.sort(function(a,b){
  return b.popularity - a.popularity
  });
  renderFeed(sortedOutfits);
}

function sortByRecent() {
  var sortedOutfits = currentFeed.sort(function(a,b){
  return Date.parse(b.created_at) - Date.parse(a.created_at)
  });
  renderFeed(sortedOutfits);
}

function Outfit() {
  this.outfit_id= ""
  this.title= ""
  this.image= ""
  this.articles= []
  this.avg_rating= 0
  this.caption= ""
  this.user= ""
  this.popularity = 0
  this.created_at = ""
  this.ratings = []
}

function constructFeed(data){
  currentFeed = []
  for (var i=0; i < data.length; i++) {
    var outfit = new Outfit();
    outfit.outfit_id = data[i].outfit_id
    outfit.title= data[i].title
    outfit.image= data[i].image
    outfit.articles= data[i].articles
    outfit.avg_rating= data[i].avg_rating
    outfit.caption= data[i].caption
    outfit.user= data[i].user
    outfit.popularity = data[i].popularity
    outfit.created_at = data[i].created_at
    outfit.ratings = data[i].ratings
    currentFeed.push(outfit)
  }
};

function renderFeed(data){
  console.log(data)
  var source = $("#all-outfits-template").html();
  var template =Handlebars.compile(source);
  var context = {allOutfits: data};
  $('#all-outfits').html(template(context));
  addAverageRating(data);
  addRatingListener();
  newRatingStarsClick();
  newRatingStarsHover();
  constructFeed(data);

};














function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}
