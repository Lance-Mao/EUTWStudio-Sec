/**
 * 输入框增加分隔符插件
 * @author：ty_bt
 * @date：2014-08-19
 * @blog：http://blog.csdn.net/ty_bt
 * @email：ty_bt@live.cn
 */
(function($){

    /**
     * 获取光标位置
     * @param  {Dom} ctrl [要获取光标位置的dom对象]
     * @return {Number}      [返回光标的位置]
     */
    function getCursortPosition(ctrl) {//获取光标位置函数
        var CaretPos = 0;
        if (document.selection) {
            ctrl.focus();
            var Sel = document.selection.createRange();
            Sel.moveStart('character', -ctrl.value.length);
            CaretPos = Sel.text.length;
        }
        // Firefox support
        else if (ctrl.selectionStart || ctrl.selectionStart == '0')
            CaretPos = ctrl.selectionStart;
        return (CaretPos);
    }

    /**
     * 设置光标位置
     * @param {Dom对象} ctrl [要设置光标位置的dom对象]
     * @param {number} pos  [位置]
     */
    function setCaretPosition(ctrl, pos) {
        if (ctrl.setSelectionRange) {
            ctrl.focus();
            ctrl.setSelectionRange(pos, pos);
        }
        else if (ctrl.createTextRange) {
            var range = ctrl.createTextRange();
            range.collapse(true);
            range.moveEnd('character', pos);
            range.moveStart('character', pos);
            range.select();
        }
    }

    /**
     * 将一个输入框设置为有分隔符的输入框
     * @param  {Object} optionsTemp [{formatArr: 必填，格式化数组，比如手机号：[3,4,4] 表示第三个字符后有分隔符，再之后4个字符有分隔符,然后以此类推
     *                                  delimiter: 可空，分隔符，默认为一个空格‘ ’，推荐使用一个字符的分隔符，多个字符的分隔符有bug
     *                                  maxLength: 可空，最大长度，为空则自动计算
     *                                  valChange: 可空，内容改变事件，function(formatValue, value) formatValue:格式化之后的字符串，value:格式化之前的字符串}]
     */
    $.fn.formatInput = function(optionsTemp){
        var options = {
            formatArr: [],
            delimiter: ' ',
            maxLength: 0,
            valChange: null,
            input: null,
            init: function(input){
                this.input = input;
                //计算最大长度
                if(!this.maxLength){
                    for(var i = 0; i < this.formatArr.length; i++){
                        var value = this.formatArr[i];
                        this.maxLength += value;
                    }
                    this.maxLength += this.delimiter.length * (this.formatArr.length - 1);
                }
                var _this = this;
                input
                //设置文本框最大长度
                    .attr("maxlength", this.maxLength)
                    //设置按键放开事件
                    .keyup(function() {
                        var val = input.val();
                        //没变化则不进行任何操作
                        if(val == input.data("oldValue")){
                            return val;
                        }
                        var position = getCursortPosition(this);
                        var tempVal = val.substr(0, position);
                        var offset = _this.format(tempVal).length - tempVal.length;
                        input.val(_this.format(val))
                            .data("oldValue", val);
                        //还原光标位置
                        setCaretPosition(this, position + offset);
                        //内容被修改的回调
                        if(_this.valChange){
                            _this.valChange.apply(input, [input.val(), _this.getValue()]);
                        }
                    }).keyup();
            },
            //获取格式化之前的的内容
            getValue: function(){
                var reg = new RegExp(this.delimiter, "g");
                var val = this.input.val().replace(reg, '');
                this.input.data("value", val);
                return val;
            },
            //将指定字符格式化
            format: function(val){
                if(val){
                    val = val.replace(new RegExp(this.delimiter, "g"), '');
                }else{
                    val = this.getValue();
                }
                var length = 0;
                var newVal = '';
                //根据formatArr数组对字符串进行处理
                for(var i = 0; i < this.formatArr.length; i++){
                    var value = this.formatArr[i];
                    if(length < val.length){
                        if(value + length <= val.length){
                            newVal += val.substr(length, value);
                            if(i != this.formatArr.length - 1 && value + length != val.length){
                                newVal += this.delimiter;
                            }
                        }else{
                            newVal += val.substr(length);
                        }
                        length += value;
                    }
                }

                return newVal;
            }
        }
        options = $.extend(options, optionsTemp);
        options.init($(this));
        return options;

    }
})(jQuery)