library retro;

import 'package:angular/angular.dart';

class PostIt {

    String text;
    int vote;
    /* categories :
     *  1 -> Bien
     *  2 -> Peut mieux faire
     *  3 -> Pas bien
     */
    int category;
       
    PostIt([String this.text = '', int this.vote = 0, int this.category = -1]);
    
    PostIt.init(String text, int category){
      this.text = text;
      this.vote = 0;
      this.category = category;
    }
    
    addVote() {
      this.vote++;
    }
    
    removeVote() {
      if (this.vote > 0 ) this.vote--;
    }
    
    bool isEmpty() {
      return this.text == '';
    }
    
    clone(int category) => new PostIt(this.text, this.vote, category);
    
    clear() {
      this.text = '';
      this.vote = 0;
      this.category = -1;
     }    
}



@NgController(
  selector: '[retro-controller]',
  publishAs: 'retro'
)
class RetroController {
  List<PostIt> postItList;
  PostIt postItItemGood;
  PostIt postItItemMedium;
  PostIt postItItemBad;
  
  int state = 0;

  RetroController(ServerController serverController) {
    postItItemGood = new PostIt();
    postItItemMedium = new PostIt();
    postItItemBad = new PostIt();
    
    postItList  = [
      new PostIt.init('Formation Angular JS' ,0),
      new PostIt('Hacking day', 0),
      new PostIt('Pizza gratuite tout les jours de la semaine', 1),
      new PostIt('Pas d\'alcool pendant les retrospectives', 2),
    ];  

    serverController.init(this);
  }

  add(int category) {
    
    switch (category) {
      case 0:
        if (postItItemGood.isEmpty()) return;
        postItList.add(postItItemGood.clone(category));    
        postItItemGood.clear();
        break;
      case 1:
         if (postItItemMedium.isEmpty()) return;
         postItList.add(postItItemMedium.clone(category));    
         postItItemMedium.clear();
         break;
      case 2:
        if (postItItemBad.isEmpty()) return;
        postItList.add(postItItemBad.clone(category));    
        postItItemBad.clear();
        break;
      default:
        break;
    }
    print(postItList);
  }
  
  remove (PostIt postIt) {
    postItList.remove(postIt);
  }
  
  /* supprime tout les postit associé à une catégorie */
  removeAll(int category) {
    postItList.removeWhere((postIt) => postIt.category == category);
  }
  
  resetVotes() {
    postItList.forEach((postIt) => postIt.vote = 0);
  }

  String classFor(PostIt postIt) {
    return postIt.vote == 0 ? 'done' : '';
  }
  
  bool isEditMode(){
    return state == 0;
  }
  
  bool isVoteMode(){
    return state == 1;
  }
  
  bool isFinalMode(){
    return state == 2;
  }
}


// ServerController interface. Logic in main.dart determines which
// implementation we should use.
abstract class ServerController {
  init(RetroController retro);
}

// An implementation of ServerController that does nothing.
class NoServerController implements ServerController {
  init(RetroController retro) { }
}

