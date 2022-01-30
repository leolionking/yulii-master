class GoalObj {
  String title;
  String description;
  int nb_tasks;
  String image = "";
  String icon = "";
  String owner = "";

  GoalObj(this.title, this.description, this.nb_tasks, {owner = ""})
      : this.owner = owner;
}
