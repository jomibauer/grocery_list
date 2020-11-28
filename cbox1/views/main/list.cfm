<cfoutput>
    <h1>#prc.welcome#</h1>
    <h4 class="error-msg">#prc.displayMsg#</h4>

    <div class="form-box">
    <form class="remove-item-form" method="POST" action=#event.buildLink( prc.xeh.p_removeBoughtItems )#>
    <div class="to-purchase-list">
        <cfloop list=#session.list# index="i" item="x">
            
            <cfif #x# == ' '>
                <cfcontinue>
            </cfif>
            <div>
                <input type="checkbox" name="items" id="list-item" value="#x#">
                <label for="list-item"> #x# </label> 
            </div>
            
        </cfloop>
    </div>
    <div class="div-spacer">
        <input type="submit" value="Purchased!">
    </div>
    </form>

    <form class="add-item-form" method="POST" action=#event.buildLink( prc.xeh.p_addListItem )#>
        <div class="div-spacer">
            <label class="add-item-label" for="add-item-input"> Add an item to your list</label>
        </div>
        <div class="div-spacer">
            <input id="add-item-input" type="text" name="listItem">
            <input id="add-item-submit" type="submit" value="Add item">
        </div>
    </form>

    <div class="just-bought-list">
        <h3> Recently purchased </h3>
        <hr>
        <cfloop list=#session.user.getJustBought().justBought# index="i" item="x">
            
            <cfif #x# == ' '>
                <cfcontinue>
            </cfif>
            <div>
                <label> #x# </label> 
            </div>
            
        </cfloop>
    </div>

    </div>

    

    <cfdump var="#session.user.getList()#">
    <cfdump var="#session.user.getjustBought()#">
    <cfdump var="#session.user.getdateBought()#">
</cfoutput>
