import 'package:angular/angular.dart';

@NgComponent(
    selector: 'postit',
    templateUrl: 'comp/postit/postit_component.html',
    cssUrl: 'comp/postit/postit_component.css',
    publishAs: 'comp')
class PostItComponent {
  
  @NgOneWay('category')
  int category;
  
  @NgOneWay('text')
  String text;
  
  @NgTwoWay('vote')
  int vote;
  
  @NgOneWay('mode')
  int mode = 0;
  
  @NgCallback('on-remove') 
  Function removeFct;
  
  upVote() => vote++;
  downVote() => vote > 0 ? vote-- : vote;
  categoryClass() => 'category-$category';
  remove() => removeFct != null ? removeFct() : null;
}