class StateList {
  String image;
  String stateName;

  StateList({this.image, this.stateName});

  void setStateImage(String image) {
    this.image = image;
  }

  void setStateName(String name) {
    this.stateName = name;
  }

  String getStateImage() {
    return this.image;
  }

  String getStateName() {
    return this.stateName;
  }
}

List<StateList> getstatelist() {
  List<StateList> list = new List<StateList>();

//1
  StateList data = new StateList();
  data.setStateImage("assets/states/maharashtra.jpeg");
  data.setStateName("Maharashtra");
  list.add(data);

  //2
  data = new StateList();
  data.setStateImage("assets/states/delhi.jpg");
  data.setStateName("Delhi");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/gujarat.jpg");
  data.setStateName("Gujarat");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/rajas.jpeg");
  data.setStateName("Rajasthan");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/tamilnadu.jpg");
  data.setStateName("Tamil Nadu");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/madhyapardesh.jpg");
  data.setStateName("Madhya Pradesh");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/utterpardesh.jpg");
  data.setStateName("Uttar Pradesh");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/telagana.jpg");
  data.setStateName("Telangana");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/andhra.jpg");
  data.setStateName("Andhra Pradesh");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/karnatka.jpg");
  data.setStateName("Karnataka");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/kerla.jpg");
  data.setStateName("Kerala");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/jammu.jpg");
  data.setStateName("Jammu and Kashmir");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/westbengal.jpg");
  data.setStateName("West Bengal");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/harayana.jpg");
  data.setStateName("Haryana");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/punjab.jpg");
  data.setStateName("Punjab");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/bihar.jpeg");
  data.setStateName("Bihar");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/odisha.jpg");
  data.setStateName("Odisha");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/uttrakan.png");
  data.setStateName("Uttarakhand");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/jharkhand.jpg");
  data.setStateName("Jharkhand");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/himachal.jpg");
  data.setStateName("Himachal Pradesh");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/chattisgarh.jpeg");
  data.setStateName("Chhattisgarh");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/assam.jpg");
  data.setStateName("Assam");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/chandi.jpg");
  data.setStateName("Chandigarh");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/LADAKH.jpg");
  data.setStateName("Ladakh");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/anda.jpg");
  data.setStateName("Andaman and Nicobar Islands");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/meghalya.jpg");
  data.setStateName("Meghalaya");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/goa.jpg");
  data.setStateName("Goa");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/pondi.jpg");
  data.setStateName("Puducherry");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/manipur.jpg");
  data.setStateName("Manipur");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/tripura.jpg");
  data.setStateName("Tripura");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/mizoram.jpg");
  data.setStateName("Mizoram");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/arunachal.jpg");
  data.setStateName("Arunachal Pradesh");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/nagaland.jpg");
  data.setStateName("Nagaland");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/dadra.jpeg");
  data.setStateName("Dadra and Nagar Haveli");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/daman.jpg");
  data.setStateName("Daman and Diu");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/laksha.jpg");
  data.setStateName("Lakshadweep");
  list.add(data);

  data = new StateList();
  data.setStateImage("assets/states/skiikm.jpg");
  data.setStateName("Sikkim");
  list.add(data);

  return list;
}
