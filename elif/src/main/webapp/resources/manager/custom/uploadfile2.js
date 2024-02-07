
(function($){
	/* 파일 추가 */
	var $accept = ".pdf";
	
	function addFile (){
		var $fileArea = $(this).parents('.add_img_area').find('.file_area');
		var filegroup = $fileArea.data('group'); 
		var cnt = $fileArea.find('input[type="file"]').length + 1;
		var html = '<li class="item-file">\
						<div class="input-group">\
							<input type="file" name="'+filegroup+'_' + (cnt-1) + '" id="'+filegroup+'_' + (cnt-1) + '" class="upload-hidden" accept="'+$accept+'">\
							<input type="text" class="form-control upload-name" placeholder="업로드" readonly="readonly">\
							<span class="input-group-btn">\
			                     <label for="pdf_' + (cnt-1) + '" class="btn btn-primary btn-fab"><i class="fa fa-upload"></i></label>\
			                     <button type="button" class="btn btn-primary btn-fab hidden"><i class="fa fa-close"></i></button>\
								 <button type="button" class="btn btn-primary btn-fab" id="btnDelete"><i class="fa fa-close"></i></button>\
			                 </span>\
						</div>\
				    </li>\
				    ';
		function pushHtml (){
			$fileArea.append(html);
		}
		
		if($(this).is("#btnAddFile3")){
			if(cnt <= 25){
				pushHtml();
			}else{
				alert("파일 첨부는 최대 25개까지 가능합니다. ");
				return false;
			}
		}
		$fileArea.on("click" , "#btnDelete" ,deleteFile);
	}
	function deleteFile(){
		$(this).parents(".item-file").remove();
	}
	
	$("#btnAddFile3").on("click" , addFile);
	$(document).on('click','.upload-name',function(){
		$(this).parent().children('[type=file]').click();
	});
    $(document).on('change','.file_area .upload-hidden', function(){
        var filename = '';
		// 사이즈체크
		var megaSize = 30;
		var maxSize  = megaSize * 1024 * 1024    //30MB
		var fileSize = 0;

        if(window.FileReader){
            // 파일명 추출
        		if($(this)[0].files[0]){
        			filename = $(this)[0].files[0].name;
					fileSize = this.files[0].size;
        		}
        }else{
            // Old IE 파일명 추출
        		if($(this).val()){
        			filename = $(this).val().split('/').pop().split('\\').pop();
					var oas = new ActiveXObject("Scripting.FileSystemObject");
					fileSize = oas.getFile( this.value ).size;
        		}
        };
		if(fileSize>maxSize){
			alert("현재 파일사이즈는 "+ formatBytes(fileSize,2) +"이며 최대파일사이즈는 "+megaSize+" MB 입니다.");
			$(this).val('');
			return;
		}
		
        $(this).siblings('.upload-name').val(filename);
        var parent = $(this).parents('li.item-file');
        parent.children('.upload-display').remove();
        if(window.FileReader){
            //image 파일만
			if($(this)[0].files[0]){
				if (!$(this)[0].files[0].type.match(/image\//)) return;
			}else{
				return;
			}
            var reader = new FileReader();
            reader.onload = function(e){
                var src = e.target.result;
                parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
            }
            reader.readAsDataURL($(this)[0].files[0]);
        }else {
            $(this)[0].select();
            $(this)[0].blur();
            var imgSrc = document.selection.createRange().text;
            parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');

            var img = $(this).siblings('.upload-display').find('img');
            img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";        
        }
    });
})(jQuery);