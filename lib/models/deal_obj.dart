class DealObj {
  int id;
  String title;
  int nb_points;
  bool withChecked;

  DealObj(this.id, this.title, this.nb_points, {withChecked = true})
      : this.withChecked = withChecked;
}
