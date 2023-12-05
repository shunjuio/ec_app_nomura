const searchAddress = document.getElementById("search_address");

function handleClick(event) {
    const postalCode = document.getElementById("order_postal_code").value;
    // 郵便番号で"-"ありでも検索できるように、replaceを使って、"-"を削除した。
    const url = `https://zipcloud.ibsnet.co.jp/api/search?zipcode=${postalCode.replace("-", "")}`;

    // fetchがXHRに比べて、モダンでコード量が少なく書けるので、fetchを選択しました。
    fetch(url)
        .then(function (response) {
            return response.json();
        })
        .then(function (address) {
            // 横に長いのが見づらいので、変数に代入しました。
            prefecture = address.results[0].address1;
            city = address.results[0].address2;
            locality = address.results[0].address3;
            const shipping_address = prefecture +　city + locality
            document.getElementById("order_postal_code").value = postalCode;
            document.getElementById("order_shipping_address").value = shipping_address;
        });
}

searchAddress.addEventListener("click", handleClick);
