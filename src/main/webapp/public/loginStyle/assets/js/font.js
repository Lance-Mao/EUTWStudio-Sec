var container = document.querySelector('.content');
		var content = container.innerText;

		function formatContent(content, container) {
		  var contentArray = content.split(' ');
		  var formattedContent = document.createElement('div');
		  contentArray.map(function (word) {
		    formattedContent.appendChild(createWord(word));
		  });
		  console.log(contentArray);

		  container.replaceChild(formattedContent, container.firstChild);
		};

		function createWord(characters) {
		  var word = document.createElement('div');
		  var wordArray = characters.split('');
		  wordArray.map(function (char) {
		    word.appendChild(formatCharacter(char));
		  });
		  word.appendChild(formatCharacter('&nbsp;'));
		  return word;
		}

		function formatCharacter(text) {
		  var text = text === ' ' ? '&nbsp;' : text;
		  var character = document.createElement('span');
		  character.innerHTML = text;
		  return character;
		}

		formatContent(content, container);