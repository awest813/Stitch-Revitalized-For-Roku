sub init()
    m.top.backgroundColor = m.global.constants.colors.hinted.grey1
    m.top.observeField("focusedChild", "onGetfocus")
    ' m.top.observeField("itemFocused", "onGetFocus")
    m.rowlist = m.top.findNode("homeRowList")
    m.loadingSpinner = m.top.findNode("loadingSpinner")
    initLoadingSpinner(m.loadingSpinner)
    m.statusMessage = m.top.findNode("statusMessage")
    m.rowlist.ObserveField("itemSelected", "handleItemSelected")
end sub

sub updatePage()
    m.top.pageTitle = m.top.contentRequested.gameName
    m.GetContentTask = CreateObject("roSGNode", "TwitchApiTask") ' create task for feed retrieving
    ' observe content so we can know when feed content will be parsed
    m.GetContentTask.observeField("response", "handleRecommendedSections")
    m.GetContentTask.request = {
        type: "getGameDirectoryQuery",
        params: {
            gameAlias: m.top.contentRequested.gameName
        }
    }
    m.getcontentTask.functionName = m.getcontenttask.request.type
    m.getcontentTask.control = "run"
end sub

function buildContentNodeFromShelves(streams)
    itemsPerRow = 3
    contentCollection = createObject("RoSGNode", "ContentNode")
    row = createObject("RoSGNode", "ContentNode")
    for i = 0 to (streams.count() - 1) step 1
        if i mod itemsPerRow = 0
            row = createObject("RoSGNode", "ContentNode")
        end if
        stream = streams[i]
        if stream = invalid or stream.node = invalid or stream.node.broadcaster = invalid then continue for
        row.title = ""
        rowItem = createObject("RoSGNode", "TwitchContentNode")
        rowItem.contentId = stream.node.Id
        rowItem.contentType = "LIVE"
        rowItem.previewImageURL = Substitute("https://static-cdn.jtvnw.net/previews-ttv/live_user_{0}-{1}x{2}.jpg", stream.node.broadcaster.login, "1280", "720")
        rowItem.contentTitle = stream.node.broadcaster.broadcastSettings.title
        rowItem.viewersCount = stream.node.viewersCount
        rowItem.streamerDisplayName = stream.node.broadcaster.displayName
        rowItem.streamerLogin = stream.node.broadcaster.login
        rowItem.streamerId = stream.node.broadcaster.id
        rowItem.streamerProfileImageUrl = stream.node.broadcaster.profileImageURL
        ' rowItem.gameDisplayName = stream.node.game.displayName
        ' rowItem.Title = stream.node.broadcaster.broadcastsettings.title
        ' rowItem.secondaryTitle = stream.node.broadcaster.displayName
        ' rowItem.HDPosterUrl = Substitute("https://static-cdn.jtvnw.net/previews-ttv/live_user_{0}-{1}x{2}.jpg", stream.node.broadcaster.login, "1280", "720")
        ' rowItem.ShortDescriptionLine1 = stream.node.viewersCount
        ' rowItem.ShortDescriptionLine2 = stream.node.game.displayName
        row.appendChild(rowItem)
        if row.getChildCount() = itemsPerRow
            contentCollection.appendChild(row)
        end if
    end for
    ' Keep the trailing partial row instead of dropping its items
    if row.getChildCount() > 0 and row.getChildCount() < itemsPerRow
        contentCollection.appendChild(row)
    end if
    return contentCollection
end function


sub updateRowList(contentCollection)
    rowItemSize = []
    showRowLabel = []
    rowHeights = []
    for each row in contentCollection.getChildren(contentCollection.getChildCount(), 0)
        if row.title <> ""
            hasRowLabel = true
        else
            hasRowLabel = false
        end if
        showRowLabel.push(hasRowLabel)
        if row.getchild(0).contentType = "LIVE" or row.getchild(0).contentType = "VOD"
            rowItemSize.push([320, 180])
            if hasRowLabel
                rowHeights.push(275)
            else
                rowHeights.push(235)
            end if
        end if
        if row.getchild(0).contentType = "GAME"
            rowItemSize.push([188, 250])
            if hasRowLabel
                rowHeights.push(325)
            else
                rowHeights.push(305)
            end if
        end if
    end for
    m.rowList.rowHeights = rowHeights
    m.rowlist.showRowLabel = showRowLabel
    m.rowlist.rowItemSize = rowItemSize
    m.rowlist.content = contentCollection
    m.rowlist.numRows = contentCollection.getChildCount()
end sub


sub handleRecommendedSections()
    if m.loadingSpinner <> invalid then m.loadingSpinner.visible = false
    contentCollection = invalid
    response = m.GetContentTask.response
    if response <> invalid and response.data <> invalid and response.data.game <> invalid and response.data.game.streams <> invalid and response.data.game.streams.edges <> invalid
        contentCollection = buildContentNodeFromShelves(response.data.game.streams.edges)
    end if
    if contentCollection <> invalid and contentCollection.getChildCount() > 0
        if m.statusMessage <> invalid then m.statusMessage.visible = false
        updateRowList(contentCollection)
    else if response <> invalid and response.data <> invalid
        showStatusMessage(tr("No live channels"), tr("Nobody is streaming this category right now."))
    else
        showStatusMessage(tr("Something went wrong"), tr("Check your internet connection and try again."))
    end if
end sub

sub showStatusMessage(title, subtitle)
    if m.loadingSpinner <> invalid then m.loadingSpinner.visible = false
    if m.statusMessage <> invalid
        m.statusMessage.title = title
        m.statusMessage.subtitle = subtitle
        m.statusMessage.visible = true
    end if
end sub

sub handleItemSelected()
    selectedRow = m.rowlist.content.getchild(m.rowlist.rowItemSelected[0])
    selectedItem = selectedRow.getChild(m.rowlist.rowItemSelected[1])
    m.top.contentSelected = selectedItem
end sub

sub onGetFocus()
    if m.rowlist.focusedChild = invalid
        m.rowlist.setFocus(true)
    else if m.rowlist.focusedChild.id = "homeRowList"
        m.rowlist.focusedChild.setFocus(true)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press
        ? "Home Scene Key Event: "; key
        if key = "back"
            m.top.backPressed = true
            return true
        end if
    end if
    return false
end function
