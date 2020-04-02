' Library "Roku_Ads.brs"
 function init()
 	m.video = m.top.findNode("myVideo")
	 m.content = m.top.content
	m.MarkupGrid = m.top.findNode("headerMarkupGrid")

	m.OnStage = m.top.findNode("OnStage")
	m.Hackathons = m.top.findNode("Hackathons")
	m.SizzleReels = m.top.findNode("SizzleReels")
	m.InVideo = m.top.findNode("InVideo")
	m.OnStageLabel = m.top.findNode("OnStageLabel")
	m.HackathonsLabel = m.top.findNode("HackathonsLabel")
	m.SizzleReelsLabel = m.top.findNode("SizzleReelsLabel")
	m.InVideoLabel = m.top.findNode("InVideoLabel")	


	m.MarkupGrid.observeField("itemFocused","OnKeyEvent")
	m.MarkupGrid.observeField("itemFocused","readFocus")

	' SetVideo
	m.OnStage.ObserveField("rowItemFocused", "OnKeyEvent")
	m.OnStage.ObserveField("rowItemFocused", "setVideo")

	m.Hackathons.ObserveField("rowItemFocused", "OnKeyEvent")
	m.Hackathons.ObserveField("rowItemFocused", "setVideo")

	m.SizzleReels.ObserveField("rowItemFocused", "OnKeyEvent")
	m.SizzleReels.ObserveField("rowItemFocused", "setVideo")

	m.InVideo.ObserveField("rowItemFocused", "OnKeyEvent")
	m.InVideo.ObserveField("rowItemFocused", "setVideo")

	' PlayVideo
	m.OnStage.observeField("rowItemSelected","playVideo")
	m.Hackathons.observeField("rowItemSelected","playVideo")
	m.SizzleReels.observeField("rowItemSelected","playVideo")
	m.InVideo.observeField("rowItemSelected","playVideo")

	m.video.observeField("state","controlVideoState")

	m.MarkupGrid.content = CreateObject("roSGNode","MarkupGridContent")

      m.readXMLContentTask = createObject("roSGNode", "ContentReader")
      m.readXMLContentTask.observeField("content", "setVideo")
      m.readXMLContentTask.contenturi = "https://c.gumgum.com/ads/com/drew_test/roku_content/videoContent_V3.xml"
      m.readXMLContentTask.control = "RUN"

	m.MarkupGrid.setFocus(true)

end function                                                                                                                                                                                                                                   

	sub setVideo()

		m.content = m.readXMLContentTask.content

			os_row = m.OnStage.rowItemFocused[0]
	        os_col = m.OnStage.rowItemFocused[1]
	        hack_row = m.Hackathons.rowItemFocused[0]
	        hack_col = m.Hackathons.rowItemFocused[1]
	        sr_row = m.SizzleReels.rowItemFocused[0]
	        sr_col = m.SizzleReels.rowItemFocused[1]
	        inVideo_row = m.InVideo.rowItemFocused[0]
	        inVideo_col = m.InVideo.rowItemFocused[1]	

		rowOneOnStage = m.content.getChild(0)
		rowTwoOnStage = m.content.getChild(1)

		rowOneHackathon = m.content.getChild(2)
		rowTwoHackathon = m.content.getChild(3)

		rowOneInVideo = m.content.getChild(4)
		rowTwoInVideo = m.content.getChild(5)

		rowOneSizzle = m.content.getChild(6)
		rowTwoSizzle = m.content.getChild(7)

	if m.MarkupGrid.itemFocused = 0 OR m.MarkupGrid.itemFocused = -1 then
			if os_row = 0
				For i=0 to rowOneOnStage.getChildCount() Step 1
					print "rowOneOnStage " rowOneOnStage.getChild(os_col).url
					m.content.url = rowOneOnStage.getChild(os_col).url
				End For
			End if

			if os_row = 1
				For i=0 to rowTwoOnStage.getChildCount() Step 1
					print "rowTwoOnStage " rowTwoOnStage.getChild(os_col).url
					m.content.url = rowTwoOnStage.getChild(os_col).url
				End For
			End if
	end if

	if m.MarkupGrid.itemFocused = 1 then
			if hack_row = 0
				For i=0 to rowOneHackathon.getChildCount() Step 1
					print "rowOneHackathon " rowOneHackathon.getChild(hack_col).url
					m.content.url = rowOneHackathon.getChild(hack_col).url
				End For
			end if
			if hack_row = 1
				For i=0 to rowTwoHackathon.getChildCount() Step 1
					print "rowTwoHackathon is "rowTwoHackathon.getChild(hack_col).url
					m.content.url = rowTwoHackathon.getChild(hack_col).url
				End For
			end if
	end if

	if m.MarkupGrid.itemFocused = 2 then
			if inVideo_row = 0
				For i=0 to rowOneInVideo.getChildCount() Step 1
					print "rowOneInVideo "rowOneInVideo.getChild(inVideo_col).url
					m.content.url = rowOneInVideo.getChild(inVideo_col).url
				End For
			end if
			if inVideo_row = 1
				For i=0 to rowTwoInVideo.getChildCount() Step 1
					print "rowTwoInVideo "rowTwoInVideo.getChild(inVideo_col).url
					m.content.url = rowTwoInVideo.getChild(inVideo_col).url
				End For
			end if
	end if

	if m.MarkupGrid.itemFocused = 3 then
			if sr_row = 0
				For i=0 to rowOneSizzle.getChildCount() Step 1
					print "rowOneSizzle "rowOneSizzle.getChild(sr_col).url
					m.content.url = rowOneSizzle.getChild(sr_col).url
				End For
			end if

			if sr_row = 1
				For i=0 to rowTwoSizzle.getChildCount() Step 1
					print "rowTwoSizzle "rowTwoSizzle.getChild(sr_col).url
					m.content.url = rowTwoSizzle.getChild(sr_col).url
				End For
			end if			
	end if
		m.video.content = m.content

	end sub

    sub playVideo()
    
      m.video.visible = false

	    m.PlayerTask = CreateObject("roSGNode", "PlayerTask")
        m.PlayerTask.video = m.video
        m.PlayerTask.control = "RUN"
		
' use the following code when not using RAF
		m.video.visible = true
		m.video.control = "play"
        m.video.setFocus(true)
    end sub

    sub	controlVideoState()
    	if(m.video.state = "finished")
    		m.video.control = "stop"
    		m.video.visible = false
    	end if
    end sub 

	function readFocus()
'''  Focus on CV grid   '''
	if m.MarkupGrid.itemFocused = 0 OR m.MarkupGrid.itemFocused = -1 then 
			print "item has focus of " m.MarkupGrid.itemFocused
			
			m.OnStage.visible = true
			m.OnStageLabel.visible = true
			m.Hackathons.visible = false
			m.HackathonsLabel.visible = false
			m.SizzleReels.visible = false
			m.SizzleReelsLabel.visible = false
			m.InVideo.visible = false
			m.InVideoLabel.visible = false
		end if

		'''  Focus on Hackathons grid   '''
			if m.MarkupGrid.itemFocused = 1 then
				print "item has focus of " m.MarkupGrid.itemFocused
				m.Hackathons.visible = true
				m.HackathonsLabel.visible = true
				m.OnStage.visible = false
				m.SizzleReels.visible = false
				m.InVideo.visible = false

				m.OnStageLabel.visible = false
				m.SizzleReelsLabel.visible = false
				m.InVideoLabel.visible = false

			end if

		'''  Focus on SizzleReels grid   '''
			if m.MarkupGrid.itemFocused = 2 then
				print "item has focus of " m.MarkupGrid.itemFocused
				m.InVideo.visible = true
				m.InVideoLabel.visible = true
				m.Hackathons.visible = false
				m.SizzleReels.visible = false
				m.OnStage.visible = false

				m.OnStageLabel.visible = false
				m.SizzleReelsLabel.visible = false
				m.HackathonsLabel.visible = false
			end if

		'''  Focus on In Video grid   '''
			if m.MarkupGrid.itemFocused = 3 then
				print "item has focus of " m.MarkupGrid.itemFocused
				m.SizzleReels.visible = true
				m.SizzleReelsLabel.visible = true
				m.InVideo.visible = false				
				m.Hackathons.visible = false
				m.OnStage.visible = false

				m.InVideoLabel.visible = false
				m.OnStageLabel.visible = false
				m.HackathonsLabel.visible = false

			end if			
	end function

function OnKeyEvent(key as String, press as Boolean) as Boolean

			os_row = m.OnStage.rowItemFocused[0]
	        os_col = m.OnStage.rowItemFocused[1]
	        hack_row = m.Hackathons.rowItemFocused[0]
	        hack_col = m.Hackathons.rowItemFocused[1]
	        sr_row = m.SizzleReels.rowItemFocused[0]
	        sr_col = m.SizzleReels.rowItemFocused[1]
	        inVideo_row = m.InVideo.rowItemFocused[0]
	        inVideo_col = m.InVideo.rowItemFocused[1]		
	        
	        print "markup is in focus chain? "; m.MarkupGrid.isInFocusChain() 
			print "markup grid itemFocused "; m.MarkupGrid.buttonFocused
			print "os_row focus is "; os_row
			print "os_col focus is "; os_col
			print "hack_row focus is "; hack_row
			print "hack_col focus is "; hack_col
			print "sr_row focus is "; sr_row
			print "sr_col focus is "; sr_col
			print "inVideo_row focus is "; inVideo_row
			print "inVideo_col focus is "; inVideo_col
			print "///////////////////////"

	if press then

		if m.video.visible = true then
			if key = "back"
					m.video.control = "stop"
					m.video.visible = false

						if m.MarkupGrid.itemFocused = 0 OR m.MarkupGrid.itemFocused= -1 then
							m.OnStage.setFocus(true)
						end if

						if m.MarkupGrid.itemFocused = 1 then
							m.Hackathons.setFocus(true)
						end if
						
						if m.MarkupGrid.itemFocused = 2 then
							m.InVideo.setFocus(true)
						end if

						if m.MarkupGrid.itemFocused = 3 then
							m.SizzleReels.setFocus(true)
						end if

					return true
			end if
		end if

'''  Switch focus from row list to nav bar   '''
		if m.MarkupGrid.HasFocus() = false Then
				if	os_row = 0 then
					if (key = "up")
						m.MarkupGrid.setFocus(true)
						end if
				end if
				
				if	hack_row = 0 then
					if (key = "up")
						m.MarkupGrid.setFocus(true)
						end if
				end if

				if	sr_row = 0 then
					if (key = "up")
						m.MarkupGrid.setFocus(true)
						end if
				end if

				if	inVideo_row = 0 then
					if (key = "up")
						m.MarkupGrid.setFocus(true)
						end if
				end if				
		End If

			if m.MarkupGrid.itemFocused = 0 OR m.MarkupGrid.itemFocused= -1 then 
				if (key = "down") then
						m.OnStage.setFocus(true)
				end if
			end If

			if m.MarkupGrid.itemFocused = 1 then
				if (key = "down") then
						m.Hackathons.setFocus(true)
				end if
			end if

			if m.MarkupGrid.itemFocused = 2 then
				if (key = "down") then
						m.InVideo.setFocus(true)
				end if
			end if

			if m.MarkupGrid.itemFocused = 3 then
				if (key = "down") then
						m.SizzleReels.setFocus(true)
				end if
			end if

	end if
end function