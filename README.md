# Prj2_KakaoMap
카카오맵_연습

# 카카오 개발 소스코드 활용 후 인포윈도우 위치 부정확 오류 ##

== 오류코드 ==
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

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			map.setBounds(bounds);
		}
	}

 == 오류내용 ==

 루프가 사용되어 data[i] 위치의 맨 마지막 장소가 인포윈도우로 출력되어 정확하지 않은 위치가 출력됨

 == 수정코드 ==

 // 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
		if (status === kakao.maps.services.Status.OK) {
			// 첫 번째 장소 데이터 선택
			var firstPlace = data[0];
			var placePosition = new kakao.maps.LatLng(firstPlace.y, firstPlace.x);
			
			// 마커를 검색 장소로 이동
			marker.setPosition(placePosition);
			
			// 마커를 표시
			marker.setMap(map);
			
			// 인포윈도우 내용 설정
			var content = '<div class="infoWindow">' + firstPlace.place_name + '</div>';
			infowindow.setContent(content);
			
			// 인포윈도우를 마커 위치에 표시
			infowindow.open(map, marker);

			// 지도 중심을 첫 번째 장소 위치로 이동
			map.setCenter(placePosition);
		}
	}

 == 수정내용 ==

 루프를 제거하고 첫 장소 데이터를 선택할 수 있도록 코드를 수정

 == 결과 ==

 정상작동 : 처음 위치에 인포윈도우 생성 확인
