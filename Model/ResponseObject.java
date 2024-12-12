package com.example.FlutterSpringbootDemo.Model;

public class ResponseObject {
    private String status;
    private String message;
    private Object data;

    public ResponseObject(String status, String message, Object data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getFoundProduct() {
        return data;
    }

    public void setFoundProduct(Object foundProduct) {
        this.data = foundProduct;
    }
}
