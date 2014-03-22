library retro;

import 'package:angular/angular.dart';

class PostIt {

    String text;
    int vote;
    int category;
       
    PostIt({ String this.text : '', int this.vote : 0, int this.category : -1 });
    
    PostIt.init(this.text, this.category, [this.vote = 0]);
    
    upVote() => vote++;
    downVote() => vote > 0 ? vote-- : vote;
    getCategoryClass() => 'category-$category';
}



@NgController(
  selector: '[retro-controller]',
  publishAs: 'retro'
)
class RetroController {
  
  List<PostIt> postItList;
  String newPostItTextGood;
  String newPostItTextAverage;
  String newPostItTextBad;
  
  int mode = 0;

  RetroController(ServerController serverController) {
    postItList  = [
      new PostIt.init('Formation Angular JS' ,0, 5),
      new PostIt.init('Hacking day', 0, 12),
      new PostIt.init('Pizza gratuite tout les jours de la semaine', 1, 6),
      new PostIt.init('Pas d\'alcool pendant les retrospectives', 2, 4),
    ];  

    serverController.init(this);
  }

  add(int cat, String text) => this ..postItList.add(new PostIt(text: text, category: cat))
                                    ..newPostItTextGood='' 
                                    ..newPostItTextAverage='' 
                                    ..newPostItTextBad='';
  
  remove(PostIt postIt) =>postItList.remove(postIt); 
  removeAll(int category) => postItList.removeWhere((postIt) => postIt.category == category);
  reset() => postItList.forEach((postIt) => postIt.vote = 0);
  
  setMode(int m) => mode = m;
  
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

