<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>키워드로 장소검색하고 목록으로 표출하기</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2018aba68a862de1abac7146f97b0e2e&libraries=services,clusterer,drawing"></script>
</head>
<body>
	<div class="option">
		<div>
			<form onsubmit="searchPlaces(); return false;">
			<br>
				키워드 : <input type="text" id="keyword" size="15">
				<button type="submit">검색하기</button>
			</form>
		</div>
	</div>
	<br>
	<hr>

	<div id="map" style="width: 100%; height: 500px;"></div>
	<a href="#" id="clickLatlng">장소 저장</a>
	<input id="x" type="hidden" value="37.5667701408774">
	<input id="y" type="hidden" value="126.97864095520264">

	<script>
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		var mapContainer = document.getElementById('map'); // 지도를 표시할 div
		var mapOption = {
			center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 초기 중심좌표
			level : 2
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);		
		
		var marker = new kakao.maps.Marker({
			// 지도 중심좌표에 마커를 생성합니다
			position : map.getCenter()
		});
		// 지도에 마커를 표시합니다
		marker.setMap(map);

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		function searchPlaces() {
			var keyword = document.getElementById('keyword').value;

			// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
			ps.keywordSearch(keyword, placesSearchCB);
		}

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {
				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기 위해 LatLngBounds 객체에 좌표를 추가합니다
				var bounds = new kakao.maps.LatLngBounds();

				for (var i = 0; i < data.length; i++) {
					var placePosition = new kakao.maps.LatLng(data[i].y, data[i].x);
					
					// 마커를 검색 장소로 이동
					marker.setPosition(placePosition);
					
					// 마커를 표시					
					marker.setMap(map);
					
					// 좌표 추가
					bounds.extend(placePosition);
				}
				
/* 		// 마커 클릭 이벤트 리스너를 추가하여 인포윈도우 열기
		kakao.maps.event.addListener(marker, 'click', function() {
			infowindow.setContent(data[0].place_name);
			infowindow.open(map, marker);
		}); */

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				map.setBounds(bounds);
			}
		}

	</script>
</body>
</html>