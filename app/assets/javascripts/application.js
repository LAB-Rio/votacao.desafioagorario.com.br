// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require storejson
//= require store
//= require_tree .

$(document).ready(function(){

  $(function(){ $(document).foundation(); });
});



window.App = {
  
  initialize: function() {
    this.proposals = store.get('proposals');
    this.fillSelectedBoxes();
    this.watchSelected();
    this.disableButtons();
    this.addToSelected();
  },

  disableButtons: function(){
    if ( this.proposals.length == 0 ) {
      return false;
    }

    for (i=0; i < this.proposals.length; i++){
      var obj = $('.proposal-text .select-proposal[data-id='+this.proposals[i]+']')
      
      obj.toggleClass('disabled');
      obj.text('Deselecionar projeto');
    }
  },

  updateCounter: function(){
    $('span.selected-count').html(this.proposals.length);
  },

  fillSelectedBoxes: function(){
    if ( this.proposals !== undefined ) {
      console.log(this.proposals);
        
      for (i=0; i < this.proposals.length; i++) {
        $('div.proposal[data-id='+this.proposals[i]+']').toggleClass('selected');
        console.log(this.proposals[i]);
      }

    } else {
      this.proposals = [];
    }

    this.updateCounter();

  },  

  watchSelected: function() {
    var self = this;

    $('.proposals .select-proposal').on('click', function(e){
        e.preventDefault();
        var id = $(this).data('id');
        var el = $('div.proposal[data-id='+id+']');

        el.toggleClass('selected');


        if (!el.hasClass('selected')) {
          self.proposals.splice(self.proposals.indexOf(id), 1);
          store.set('proposals', self.proposals);
        } else {
          self.proposals.push(id);
          store.set('proposals', self.proposals);
        }

        console.log(store.get('proposals'));
        self.updateCounter();

    });

  },

  addToSelected: function(){
    var self = this;

    $('.proposal-text .select-proposal').on('click', function(e){
      e.preventDefault();
      var obj = $(this);
      var id = obj.data('id');

      if (self.proposals.indexOf(id) != -1) {
        /* already in there */
        self.proposals.splice(self.proposals.indexOf(id) ,1);
        store.set('proposals', self.proposals);
        obj.toggleClass('disabled');
        obj.text('Selecionar este projeto');

      } else {
        self.proposals.push(id);
        obj.toggleClass('disabled');
        store.set('proposals', self.proposals);
        obj.text('Deselecionar este projeto');
      }

      self.updateCounter();
    });
  }



};


window.App.initialize();


