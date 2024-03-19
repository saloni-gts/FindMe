import '../components/addMobNum.dart';
import 'staus_enum.dart';

class Resource<T> {
  late Status status;
  late T data;
  late String message = "";

  Resource(this.status, this.data, this.message);

  Resource.success(this.data, this.message) {
    status = Status.success;
  }

  Resource.error(this.data, this.message) {
    status = Status.error;
  }
  Resource.errors(this.data, this.message) {
    status = Status.errorrs;
  }
  Resource.expair(this.data, this.message) {
    status = Status.error;
  }
  Resource.userexpire(this.data, this.message) {
    status = Status.userexpired;
  }

  Resource.loading(this.data, this.message) {
    status = Status.loading;
  }

  Resource.inValidMobile(this.data,this.message){
    status=Status.inValidMob;
  }

  Resource.forceLogout(this.data,this.message){
    status=Status.forceLogout;
  }

  Resource.loadingEmpty() {
    status = Status.loading;
  }
}

Status getStatus(int statusCode) {
  switch (statusCode) {
    case 200:
      {
        return Status.success;
      }

    case 201:
      {
        return Status.inValidMob;
      }

    case 401:
      {
        return Status.forceLogout;
      }

    default:
      {
        return Status.error;
      }
  }
}
