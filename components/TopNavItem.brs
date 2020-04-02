sub init()
	m.itemLabel = m.top.findNode("itemLabel")
	m.itemcursor = m.top.findNode("itemcursor")
end sub

    sub showcontent()
      m.itemLabel.text = m.top.itemContent.title
    end sub

    sub showfocus()
      print "fp is " m.top.focusPercent
      m.itemcursor.opacity = m.top.focusPercent

      if m.top.index = 0
        m.itemcursor.width = "170"
      else if m.top.index = 1
        m.itemcursor.width = "210"
      else if m.top.index = 2
        m.itemcursor.width = "155"
      end if
      
 
  end sub
  
