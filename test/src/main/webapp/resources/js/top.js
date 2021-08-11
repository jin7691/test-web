/**
 * 
 */
 $(document).ready(function() {
	 $("#menu li").click(function(){
		$("#menu").find(".active").removeClass("active")
		$(this).find("a").addClass("active")
	});
});

 
 
 