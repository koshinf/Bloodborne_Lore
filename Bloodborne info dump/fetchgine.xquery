xquery version "3.1";

(:the purpose of this code snippet is not to output anything specific.
 : instead, its purpose is to function as an output "engine".
 : It contains functionality :)
 
let $weapons := collection('/db/bloodborne')//weapon

let $input1 := "CHURCH"

let $input2 := "BEAST"

let $items := $weapons/*[contains(upper-case(.),$input1) and contains(upper-case(.),$input2)]

let $names := $items/../@weaponList/string()

let $input := $names

for $grain in $input

(: For loop for input :)

let $tokenPass := tokenize($input,"=")

(: tokenizer. Feel free to change the separator :)

for $token in $input

(: For loop for tokens :)

let $tsvDirOutput := concat("CHURCH","&#x9;", $grain, "&#x9;", "BEAST","\n")

(: Joins strings together directly from the input :)

let $tsvForOutput := "X"

(: Joins strings together from the input for loop :)

let $tsvTokenOutput := string-join($tokenPass, "    ")

let $tsvTokenForOutput := string-join($token, " ")

(: The same thing, now with tokens!:)

let $distinct := distinct-values($tsvDirOutput)

let $output := $tsvDirOutput

(: For some weird reason, this thing outputs multiple html files. Only use the first.
 : Also, THERE WILL BE DOUBLE QUOTES IN YOUR HTML THANKS TO EXIDE. YOU MUST FIX THIS FOR IT TO WORK. PLEASE :)

return concat('
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>
            Download your output!
            </title>
    </head>
    <body>
        {
        
        
        <div>
            
            
        
            
            <div id="content">',
            
                $output, (:output is put into div:) 
            '
            </div>
            
            <button onclick = "download()"> Download </button>
            
            
            <script>
            function download() 
            {
            
            //I will be 100% honest, this was very hard to do so I ripped a script from stackoverflow for saving a file to the computer
            //and edited it to suit our purposes: the XQuery outputs html, and this script takes that html output and saves it as a
            //text file. Yes, I have made a TSV factory.
                
                var filename = "output.txt";
                
                var type = "plain/text";
                
                var node = document.getElementById("content");
            
                var data = node.innerHTML;
            
                var file = new Blob([data], {type: type});
            
                if (window.navigator.msSaveOrOpenBlob) 
                IE10+ window.navigator.msSaveOrOpenBlob(file, filename);
                else { 
                // Others
            
                var a = document.createElement("a"),
            
                url = URL.createObjectURL(file);
            
                a.href = url;
            
                a.download = filename;
            
                document.body.appendChild(a);
            
                a.click();
            
                setTimeout(
                            function() 
                            {
            
                            document.body.removeChild(a);
            
                            window.URL.revokeObjectURL(url);  
            
                            }
                        , 0); 
            }
            }
            
            </script>
        </div>
        }
    </body>
</html>
')