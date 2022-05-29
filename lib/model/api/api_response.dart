class ApiResponse<T> {
  Status status;
  T? data;
  String? mess;

  ApiResponse.initial(this.mess) : status = Status.INITIAL;
  ApiResponse.loading(this.mess) : status = Status.LOADING;
  ApiResponse.completed(this.mess) : status = Status.COMPLETED;
  ApiResponse.error(this.mess) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status \nMessage: $mess \nData: $data";
  }
}

enum Status { INITIAL, LOADING, COMPLETED, ERROR }
