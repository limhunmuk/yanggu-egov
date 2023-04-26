function showMapYX(spot,many) {
	
	console.log("spot="+spot);
	
	array = spot.split(',');
	la=array[0];
	ln =array[1];
	console.log("la="+la);
	console.log("ln="+ln);
	if(many==0){
		var mapContainer = document.getElementById('map') // 지도를 표시할 div
		console.log("mapContainer1 : "+'map');
	}else{
		var mapContainer = document.getElementById('map'+many) // 지도를 표시할 div
		console.log("mapContainer2 : "+'map'+many);
	}
	mapOption = {
			center: new daum.maps.LatLng(la, ln), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
		};
	// 지도를 생성합니다
	var map = new daum.maps.Map(mapContainer, mapOption);

	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new daum.maps.MapTypeControl();

	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new daum.maps.ZoomControl();
	map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

	var coords = new daum.maps.LatLng(la, ln);

	// 결과값으로 받은 위치를 마커로 표시합니다
	var marker = new daum.maps.Marker({
		map: map,
		position: coords
	});

	// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	//map.setCenter(coords);
}

//태그 제거 함수
function stipTag(str) {
	return str.replace(/(<([^>]+)>)/ig,"");
}