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
//= require nprogress
//= require nprogress-turbolinks
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
    this.refreshFormFields();
    this.watchForm();
    this.watchFixedMsgActions();
    this.watchUndoSelection();
    this.cleanSelection();
    this.undoAction = false;

  },

  refreshFormFields: function(){
    var input = '';
    var arrSize = this.proposals.length;

    if (arrSize > 0) {
      for (i = 0; i < arrSize; i++) {
        input += '<input type="hidden" name="proposals[user_proposals][]" value="'+this.proposals[i]+'"/>';
      }
      
      $('#proposalForm .inputs').html('').append(input);
    }
  },

  watchUndoSelection: function(){
    var self = this;
    $('.select-proposal-undo').click(function(){
      self.undoAction = true;
      $('.select-proposal[data-id='+$(this).data('id')+']').click();

    });
  },

  watchForm: function(){
    var self = this;

    $('#proposalForm button.submit').on('click', function(e){
      var arrSize = self.proposals.length; 

      if( arrSize == 0) {
        e.preventDefault();
        alert('Você precisa selecionar pelo menos uma proposta.');
      } 
      else if (arrSize > 0) {
        e.preventDefault();
        $('.fixed-msg').fadeIn();
      }


    });

  },

  cleanSelection: function() {
    var self = this;
    $('.clean-selection').click(function(e){
      e.preventDefault();
      if ( self.proposals.length > 0 ) {
        $('.proposal.selected').removeClass('selected');
        store.set('proposals', []);
        self.proposals = [];
        self.updateCounter();
      }
    });
  },

  watchFixedMsgActions: function(){
    $('.fixed-msg .close').click(function(){
      $('.fixed-msg').fadeOut();
    });

    $('.fixed-msg .save').click(function(){
      $('#proposalForm').submit();
    });
  },

  disableButtons: function(){
    if ( this.proposals.length == 0 ) {
      return false;
    }

    for (i=0; i < this.proposals.length; i++){
      var obj = $('.proposal-text .select-proposal[data-id='+this.proposals[i]+']')
      
      obj.toggleClass('disabled');
      obj.text('Desfazer seleção');
    }
  },

  updateCounter: function(){
    $('span.selected-count').html(this.proposals.length);
    $('span.left-counter').html(10 - this.proposals.length);
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

/*        if (self.proposals.length > 9 && self.undoAction == false) {*/
          //alert('Você já selecionou 10 projetos. Você pode desfazer ou limpar a seleção atual se quiser votar em um novo projeto.')
          //return false;
        /*}*/

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

        //console.log(store.get('proposals'));
        
        self.updateCounter();
        self.refreshFormFields();
        self.undoAction = false;
    });

  },

  addToSelected: function(){
    var self = this;

    $('.proposal-text .select-proposal').on('click', function(e){

      e.preventDefault();
/*      if (self.proposals.length > 9) {*/
        //alert('Você já selecionou 10 projetos. Você pode desfazer ou limpar a seleção atual se quiser votar em um novo projeto.')
        //return false;
      //}




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
        obj.text('Desfazer seleção');
      }

      self.updateCounter();
      self.refreshFormFields();
    });
  }



};


window.App.initialize();


