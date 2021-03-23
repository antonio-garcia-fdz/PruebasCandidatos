// load json into array
let jsonStr =
  [
    {
      "Name": "Item 1",
      "Children": [
        {
          "Name": "Item 1.1",
          "Children": [
            {
              "Name": "Item 1.1.1",
              "Children": [ ]
            },
            {
              "Name": "Item 1.1.2",
              "Children": [ ]
            },
            {
              "Name": "Item 1.1.3",
              "Children": [ ]
            }
          ]
        },
        {
          "Name": "Item 1.2",
          "Children": [
            {
              "Name": "Item 1.2.1",
              "Children": [ ]
            },
            {
              "Name": "Item 1.2.2",
              "Children": [ ]
            },
            {
              "Name": "Item 1.2.3",
              "Children": [ ]
            }
          ]
        }
      ]
    },
    {
      "Name": "Item 2",
      "Children": [
        {
          "Name": "Item 2.1",
          "Children": [
            {
              "Name": "Item 2.1.1",
              "Children": [ ]
            },
            {
              "Name": "Item 2.1.2",
              "Children": [ ]
            },
            {
              "Name": "Item 2.1.3",
              "Children": [ ]
            }
          ]
        }
      ]
    }
  ]

// create variable to write the html list
var jsonls = "";
/* note: to avoid a global variable it is recomended to pass it
         as an parameter. However I did not find how to do this
         while passing an array.
*/

/*
* recursiveTraverse():
* ...arr: array containing the json to be traversed
* returns: hierarchy list of elements in the array
*/
function recursiveTraverse(...arr) {
  for (var i = 0; i < arguments.length ; i++){
    //format the element name into an html list
    jsonls += '<li>' + arguments[i]['Name'] + '</li>';
    //if the node is not a leaf
    if (arguments[i]['Children'].length > 0){
      //start a sublist and traverse de children
      jsonls += '<ul>'
      recursiveTraverse(...arguments[i]['Children']);
      jsonls += '</ul>'
    }//end if
  }//end for
  return jsonls;
}

//get desired <ul> element and add the generated list
var MyList = document.getElementById('TreeView');
MyList.innerHTML = recursiveTraverse(...jsonStr);
