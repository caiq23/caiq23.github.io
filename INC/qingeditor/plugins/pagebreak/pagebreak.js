/*******************************************************************************
* qingeditor - WYSIWYG HTML Editor for Internet
* Copyright (C) 2006-2011 cnw6.com
*
* @author cnw6 <cs@cnw6.com>
* @site http://www.cnw6.com/

*******************************************************************************/

qingeditor.plugin('pagebreak', function(K) {
	var self = this;
	var name = 'pagebreak';
	var pagebreakHtml = K.undef(self.pagebreakHtml, '<hr style="page-break-after: always;" class="ke-pagebreak" />');

	self.clickToolbar(name, function() {
		var cmd = self.cmd, range = cmd.range;
		self.focus();
		var tail = self.newlineTag == 'br' || K.WEBKIT ? '' : '<span id="__qingeditor_tail_tag__"></span>';
		self.insertHtml(pagebreakHtml + tail);
		if (tail !== '') {
			var p = K('#__qingeditor_tail_tag__', self.edit.doc);
			range.selectNodeContents(p[0]);
			p.removeAttr('id');
			cmd.select();
		}
	});
});
