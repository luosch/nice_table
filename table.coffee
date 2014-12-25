window.onload = () ->
    tableInsert = document.getElementById("tableInsert");
    niceTable = document.getElementById("niceTable");
    tableDelete = document.getElementById("tableDelete");
    selectRow = document.getElementById("selectRow");
    sortByName = document.getElementById("sortByName");
    sortByHeight = document.getElementById("sortByHeight");
    sortByWeight = document.getElementById("sortByWeight");
    name = document.getElementById("name")
    height = document.getElementById("height")
    weight = document.getElementById("weight")

    ### initialize the select options ###
    do initialize = () ->
        selectRow.innerHTML = ""
        for i in [1..niceTable.rows.length - 1]
            if i != 0
                option = document.createElement("option")
                option.value = i
                option.innerHTML = "row#{i}"
                selectRow.appendChild(option)
        if niceTable.rows.length == 1 then selectRow.innerHTML = ""
        null

    ### exchange two rows in table ###
    exchange = (a, b) ->
        rowA = niceTable.rows[a].cells
        rowB = niceTable.rows[b].cells

        niceTable.deleteRow(a)
        row = niceTable.insertRow(a)
        for item, index in rowB
            row.insertCell(index).innerHTML = item.innerHTML

        niceTable.deleteRow(b)
        row = niceTable.insertRow(b)
        for item, index in rowA
            row.insertCell(index).innerHTML = item.innerHTML
        null

    ### sort ###
    sort = (key, order) ->
        len = niceTable.rows.length - 1
        for i in [1..len]
            if i + 1 <= len
                for j in [i + 1..len]
                    cmp1 = parseInt niceTable.rows[i].cells[key].innerHTML
                    cmp2 = parseInt niceTable.rows[j].cells[key].innerHTML
                    if (order == "asc")
                        if (cmp1 > cmp2)
                            exchange(i, j)
                    else
                        if (cmp1 < cmp2)
                            exchange(i, j)
        null

    tableInsert.onclick = ()->
        row = niceTable.insertRow(niceTable.rows.length);
        if name.value == ""
            name.classList.add("buzz-out")
            setTimeout((() -> name.classList.remove("buzz-out")), 750)
        else if height.value == ""
            height.classList.add("buzz-out")
            setTimeout((() -> height.classList.remove("buzz-out")), 750)
        else if weight.value == ""
            weight.classList.add("buzz-out")
            setTimeout((() -> weight.classList.remove("buzz-out")), 750)
        else
            row.insertCell(0).innerHTML = name.value
            row.insertCell(1).innerHTML = height.value
            row.insertCell(2).innerHTML = weight.value
            name.value = height.value = weight.value = ""
        do initialize

    tableDelete.onclick = () ->
        niceTable.deleteRow parseInt selectRow.value
        do initialize

    sortByHeight.onclick = () ->
        sortByWeight.innerHTML = "weight(cm)"
        if this.innerHTML == "height(cm)↓"
            sort(1, "asc")
            this.innerHTML = "height(cm)↑"
        else
            sort(1, "desc")
            this.innerHTML = "height(cm)↓"

    sortByWeight.onclick = () ->
        sortByHeight.innerHTML = "height(cm)"
        if this.innerHTML == "weight(cm)↓"
            sort(2, "asc")
            this.innerHTML = "weight(cm)↑"
        else
            sort(2, "desc")
            this.innerHTML = "weight(cm)↓"

    null