
// khai bao bien module [app] dai dien cho ung dung AJS [myAPP] 
let app = angular.module("myAPP", []);

// khai bao va mo ta xu ly cua controller [studentCTR]
app.controller("studentCTR", function ($scope) {
    //khai bao va khoi tao gia tri bien ds: mang du lieu json, chua thong tin cua cac doi tuong mon an (id, name, hinh anh, don)
    $scope.ds = [
        {
            "id": "f01",
            "name": "banh cuon",
            "image": "Banh-Cuon-Small.png",
            "price": 45000
        },
        {
            "id": "f02",
            "name": "banh goi",
            "image": "Banh-Goi-Small.png",
            "price": 15000
        },
        {
            "id": "f03",
            "name": "banh mi thit Hong Hoa",
            "image": "Banh-Mi-Small.png",
            "price": 60000
        },
        {
            "id": "f04",
            "name": "banh xeo A Phu",
            "image": "Banh-Xeo-Small.png",
            "price": 45000
        },
        {
            "id": "f05",
            "name": "bun bo hue Dong Ba",
            "image": "Bun-Bo-Hue-Small.png",
            "price": 50000
        },
        {
            "id": "f06",
            "name": "ca phe sua da",
            "image": "Ca-Phe-Sua-Da-Small.png",
            "price": 85000
        },
        {
            "id": "f07",
            "name": "Pho",
            "image": "Pho-Small.png",
            "price": 69000
        }
    ];

});

