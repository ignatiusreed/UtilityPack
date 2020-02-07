package mm.text
{
	import flash.text.*;
	import flash.utils.*;
	import mm.draw.CustomColor;
	
	public class CustomText extends TextField
	{
		/*font_GGSubscript;
		font_GGSuperscript;
		font_HelveticaNeueLTPro75Bold;
		font_RobotoBold;
		font_RobotoBoldItalic;
		font_RobotoLight;
		font_RobotoLightItalic;
		font_RobotoMedium;
		font_RobotoMediumItalic;
		font_RobotoRegular;
		font_RobotoRegularItalic;*/
		
		/*
		textData
		
		fontName:String = "", fontSize:uint = 12,
		textColor:uint = 0, textAlign:String = "left", textAutoSize:String = "oneline"
		isHTML:Boolean = false, isInput:Boolean = false
		
		boxData
		
		boxWidth:Number = 100, boxHeight:Number = 100
		borderColor:uint = 0
		backgroundColor:uint = 0
		boxAlpha:Number = 1
		*/
		
		public static function addCustomTextBox(str:String, textData:Object, boxData:Object = null):TextField
		{
			var tf:TextField = (!textData.isHTML) ? CustomText.addRegularText(str, textData, boxData) : CustomText.addHTMLText(str, textData, boxData);
			if (boxData) setBoxStyle(tf, boxData);
			return tf;
		}
		
		public static function addRegularText(str:String, textData:Object, boxData:Object = null):TextField
		{
			var textField:TextField = new TextField();
			
			if (textData.isInput) {
				textField.type = TextFieldType.INPUT;
			} else {
				textField.selectable = false;
				textField.mouseEnabled = false;
			}
			
			if (!boxData) boxData = {};
			textField.width = (boxData.boxWidth != undefined) ? boxData.boxWidth : 100;
			textField.height = (boxData.boxHeight != undefined) ? boxData.boxHeight : 100;
			
			if (textData.textAutoSize) setAutoSize(textField, textData.textAutoSize);
			
			textField.defaultTextFormat = getTextFormat(textData);
			textField.embedFonts = true;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.gridFitType = GridFitType.SUBPIXEL;
			textField.text = str;
			
			return textField;
		}
		
		public static function addHTMLText(str:String, textData:Object, boxData:Object = null):TextField
		{
			var textField:TextField = new TextField();
			textField.selectable = false;
			textField.mouseEnabled = false;
			
			if (!boxData) boxData = {};
			textField.width = (boxData.boxWidth != undefined) ? boxData.boxWidth : 100;
			textField.height = (boxData.boxHeight != undefined) ? boxData.boxHeight : 100;
			
			if (textData.textAutoSize) setAutoSize(textField, textData.textAutoSize);
			
			textField.defaultTextFormat = getTextFormat(textData);
			textField.embedFonts = true;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.gridFitType = GridFitType.SUBPIXEL;
			textField.styleSheet = CustomText.getStyleSheet(textData);
			textField.htmlText = CustomText.parseCustomHTMLTags(CustomText.removeOrphans(str));
			
			return textField;
		}
		
		private static function getTextFormat(textData:Object):TextFormat
		{
			var tf:TextFormat = new TextFormat();
			tf.font = (textData.fontName) ? textData.fontName : "RobotoRegular";
			
			if (!textData.isHTML) {
				tf.size = (textData.fontSize) ? textData.fontSize : 12;
				tf.color = (textData.textColor) ? textData.textColor : 0x0;
				tf.align = (textData.textAlign) ? textData.textAlign : "left";
			}
			
			return tf;
		}
		
		public static function setBoxStyle(tf:TextField, boxData:Object = null):void
		{
			if (boxData.borderColor != undefined) {
				tf.border = true;
				tf.borderColor = boxData.borderColor;
			}
			if (boxData.backgroundColor != undefined) {
				tf.background = true;
				tf.backgroundColor = boxData.backgroundColor;
			}
			if (boxData.boxAlpha != undefined) {
				tf.alpha = boxData.boxAlpha;
			}
		}
		
		public static function setAutoSize(textField:TextField, autoSizeType:String):void
		{
			switch (autoSizeType) {
				case CustomTextAutoSize.ONE_LINE:
					textField.multiline = false; // default
					textField.wordWrap = false; // default
					textField.autoSize = TextFieldAutoSize.LEFT;
					break;
				case CustomTextAutoSize.COLUMN:
					textField.multiline = true;
					textField.wordWrap = true;
					textField.autoSize = TextFieldAutoSize.LEFT;
					break;
				case CustomTextAutoSize.ALL:
					textField.multiline = true;
					textField.wordWrap = false; // default
					textField.autoSize = TextFieldAutoSize.LEFT;
					break;
				case CustomTextAutoSize.NONE:
					textField.multiline = false; // default
					textField.wordWrap = false;
					break;
				default: // column
					textField.multiline = true;
					textField.wordWrap = true;
					textField.autoSize = TextFieldAutoSize.LEFT;
					break;
			}
		}
		
		public static function getStyleSheet(textData:Object):StyleSheet
		{
			var fontName:String = (textData.fontName) ? textData.fontName : "Roboto Regular";
			var fontSize:uint = (textData.fontSize) ? textData.fontSize : 12;
			var textColor:uint = (textData.textColor) ? textData.textColor : 0;
			var textAlign:String = (textData.textAlign) ? textData.textAlign : "left";
			
			var css:StyleSheet = new StyleSheet();
			css.parseCSS('a {text-decoration: underline} a:hover {text-decoration: none}');
			css.parseCSS('p {leading: 6}');
			css.parseCSS('.italic {font-style: italic; font-family: "Roboto Italic"}');
			css.parseCSS('.bold {font-style: italic; font-weight: bold; font-family: "Roboto Bold"}');
			css.parseCSS('.bold-italic {font-style: italic; font-weight: bold; font-family: "Roboto Bold Italic"}');
			css.parseCSS('.sup {font-family: "GG Superscript"}');
			css.parseCSS('.sub {font-family: "GG Subscript"}');
			
			var bodyStyle:Object = {};
			bodyStyle.textAlign = textAlign;
			bodyStyle.fontSize = fontSize;
			bodyStyle.color = CustomColor.uintToHex(textColor, true);
			
			var boldStyle:Object = {};
			boldStyle.fontWeight = "bold";
			
			var italicStyle:Object = {};
			italicStyle.fontStyle = "italic";
			
			var boldItalicStyle:Object = {};
			boldItalicStyle.fontWeight = "bold";
			boldItalicStyle.fontStyle = "italic";
			
			var lightStyle:Object = {};
			
			var lightItalicStyle:Object = {};
			lightItalicStyle.fontStyle = "italic";
			
			var mediumStyle:Object = {};
			
			var mediumItalicStyle:Object = {};
			mediumItalicStyle.fontStyle = "italic";
			
			if (fontName.indexOf("Roboto") != -1) {
				bodyStyle.fontFamily = CustomTextFontList.getFontName(fontName);
				
				boldStyle.fontFamily = "Roboto Bold";
				italicStyle.fontFamily = "Roboto Italic";
				boldItalicStyle.fontFamily = "Roboto Bold Italic";
				
				lightStyle.fontFamily = "Roboto Light";
				lightItalicStyle.fontFamily = "Roboto Light Italic";
				
				mediumStyle.fontFamily = "Roboto Medium";
				mediumItalicStyle.fontFamily = "Roboto Medium Italic";
			}
			
			css.setStyle("body", bodyStyle);
			css.setStyle(".bold", bodyStyle);
			css.setStyle(".italic", italicStyle);
			css.setStyle(".bold-italic", boldItalicStyle);
			css.setStyle(".light", lightStyle);
			css.setStyle(".light-italic", lightItalicStyle);
			css.setStyle(".medium", mediumStyle);
			css.setStyle(".medium-italic", mediumItalicStyle);
			
			return css;
		}
		
		private static function parseCustomHTMLTags(str:String):String
		{
			str = str.replace(new RegExp("{nbsp}", "g"), "&nbsp;");
			str = str.replace(new RegExp("{italic}", "g"), "<span class='it'>");
			str = str.replace(new RegExp("{/italic}", "g"), "</span>");
			str = str.replace(new RegExp("{bold}", "g"), "<span class='bd'>");
			str = str.replace(new RegExp("{/bold}", "g"), "</span>");
			str = str.replace(new RegExp("{bold-italic}", "g"), "<span class='bd-it'>");
			str = str.replace(new RegExp("{/bold-italic}", "g"), "</span>");
			str = str.replace(new RegExp("{sup}", "g"), "<span class='sup'>");
			str = str.replace(new RegExp("{/sup}", "g"), "</span>");
			str = str.replace(new RegExp("{sub}", "g"), "<span class='sub'>");
			str = str.replace(new RegExp("{/sub}", "g"), "</span>");
			str = str.replace(new RegExp("{", "g"), "<");
			str = str.replace(new RegExp("}", "g"), ">");
			return "<body>" + str + "</body>";
		}
		
		public static function trimCustomText(tf:TextField, size:Number = 0, value:String = "", dir:String = ""):void
		{
			var str:String = value ? value : tf.text;
			if (value) tf.text = value;
			
			if (dir == CustomTextAutoSize.ONE_LINE) {
				if (!size) size = tf.width;
				
				tf.autoSize = TextFieldAutoSize.LEFT;
				
				while (tf.width > size) {
					str = str.substr(0, -1);
					tf.text = str + "...";
				}
			} else if (dir == CustomTextAutoSize.COLUMN) {
				if (!size) size = tf.height;
				
				tf.multiline = true;
				tf.wordWrap = true;
				tf.autoSize = TextFieldAutoSize.LEFT;
				
				while (tf.height > size) {
					str = str.substr(0, -1);
					tf.text = str + "...";
				}
			} else {
				return;
			}
			
			while (str.substr(-1, 1) == " ") {
				str = str.substr(0, -1)
				tf.text = str + "...";
			}
		}
		
		public static function removeOrphans(str:String = ""):String
		{
			var finalStr:String = "";
			
			if (str != "") {
				var arr:Array = str.split(" ");
				
				for (var i:uint = 0; i < arr.length; i++) {
					var word:String = arr[i];
					
					if (i != arr.length - 1) {
						if (word.length == 1 /*|| (word.length == 2 && new RegExp("[,.:;!?]").test(word.charAt(1))*/) {
							finalStr += (word + String.fromCharCode(160)); // \u00A0
						} else {
							finalStr += (word + " ");
						}
					} else {
						finalStr += word;
					}
				}
			}
			
			return finalStr;
		}
		
		// ...
	}
	
	// end of class
	
}