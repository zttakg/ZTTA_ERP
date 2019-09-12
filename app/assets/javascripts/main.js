function hide_video_block(){
    document.getElementById('video_link-block').style.display ='none';
}
function show_video_block(){
    document.getElementById('video_link-block').style.display = 'block';
}
window.onload = function() {
    videoLinkBlockChecked = document.getElementById('page_element_button_true');
    if(videoLinkBlockChecked){
        videoLinkBlockChecked.checked;
        if(videoLinkBlockChecked == true){
            document.getElementById('video_link-block').style.display = 'block';
        }
        var selector = document.getElementById('page_element_element_type');
        var value = selector[selector.selectedIndex].value;
        if(value == 'slide'){
            document.getElementById('showButton').style.display = 'block';
        }
    }
};