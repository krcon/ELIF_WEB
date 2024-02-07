
$('.texteditor').summernote({
	toolbar: [
	  // [groupName, [list of button]]
	  ['style', ['style']],
	  ['fontname', ['fontname']],
	  ['fontsize',['fontsize']],
	  ['color', ['color']],
	  ['font', ['bold', 'underline', 'clear']],
	  ['para', ['ul', 'ol', 'paragraph']],
	  ['table', ['table']],
	  ['insert', ['link', 'picture', 'video']],
	  ['view', ['fullscreen', 'codeview', 'help']],
	  ['height', ['height']]
	],
	popover: {
	 image: [
	   ['image', ['resizeFull', 'resizeHalf', 'resizeQuarter', 'resizeNone']],
	   ['float', ['floatLeft', 'floatRight', 'floatNone']],
	   ['remove', ['removeMedia']]
	 ],
	 link: [
	   ['link', ['linkDialogShow', 'unlink']]
	 ],
	 table: [
	   ['add', ['addRowDown', 'addRowUp', 'addColLeft', 'addColRight']],
	   ['delete', ['deleteRow', 'deleteCol', 'deleteTable']],
	 ],
	 air: [
	   ['color', ['color']],
	   ['font', ['bold', 'underline', 'clear']],
	   ['para', ['ul', 'paragraph']],
	   ['table', ['table']],
	   ['insert', ['link', 'picture']]
	 ]
	},
	fontSizes: ['8', '9', '10', '11', '12', '13', '14', '15', '16', '17' , '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '50', '60'],
	fontNames: ['돋움','돋움체','굴림','굴림체','바탕','바탕체','Nanum Gothic','NanumSquare','NanumBarunGothic','Arial', 'Arial Black', 'Comic Sans MS', 'Courier New' ],
	fontNamesIgnoreCheck:['돋움','돋움체','Nanum Gothic','NanumSquare','NanumBarunGothic'],
	height: 250,
	lang: 'ko-KR',
	callbacks : {
		onImageUpload : function(files) {
			uploadSummernoteImageFile(files[0],this);
		}
	}
	
	
});