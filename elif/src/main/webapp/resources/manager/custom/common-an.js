function mergeCell(tableId) {
		var first = true;
		var prevRowspan1 = 1;
		var prevCell1 = null;

		var rows = $("#" + tableId + " > tbody").children();
		for (var i = 0; i < rows.length; i++ ) {
			if (first) {
				prevRow = rows[i];
				prevCell1 = $(prevRow).find("td").eq(0); // 첫열
		
				first = false;
				continue;
			}

			var row = rows[i]; // row
			var tdList = $(row).find("td"); // row > td 리스트
			var firstCell = $(tdList).eq(0); // 첫 번째 행
			var firstCellText = $(firstCell).text(); // 첫 번째 행 text 추출
		
			// 두 번째 row 부터 텍스트 비교
			if (prevCell1.text() == firstCellText) {
				prevRowspan1++;
				$(prevCell1).attr("rowspan", prevRowspan1);
				$(firstCell).remove();
			}
			else {
				prevRowspan1 = 1;
				prevCell1 = firstCell;
			}
		}
	}
