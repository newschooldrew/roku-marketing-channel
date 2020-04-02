' Library "Roku_Ads.brs"

' sub init()
'     m.top.functionName = "playContentWithAds" 
'     m.top.id = "PlayerTask"
' end sub

' sub playContentWithAds()
' video = m.top.video
' view = video.getParent()
'         RAF = Roku_Ads()
'         RAF.setAdPrefs(false)
'         RAF.setDebugOutput(true)    

'     'RAF content params
'         RAF.setContentId("P2871BBFF-1A28-44AA-AF68-C7DE4B148C32")
'         RAF.SetContentGenre("DO")
'         RAF.enableAdMeasurements(true)
'         RAF.setContentLength(3220)
        
'         RAF.setAdUrl("https://gumgum-content.s3.amazonaws.com/ads/com/drew_test/iabOverlay.xml")
'         adPods = RAF.getAds()
'         keepPlaying = true

'         'play all preroll ads
'             if adPods <> invalid and adPods.count() > 0 then
'                 keepPlaying = RAF.showAds(adPods, invalid, view)
'             endif  

'     port = CreateObject("roMessagePort")
'     if keepPlaying then
'         video.observeField("position", port)
'         video.observeField("state", port)
'         video.visible = true
'         video.control = "play"
'         video.setFocus(true) 'so we can handle a Back key interruption
'     end if

'     curPos = 0
'     adPods = invalid
'     isPlayingPostroll = false


'     while keepPlaying
'         msg = wait(0, port)
'         if type(msg) = "roSGNodeEvent"
'             print "msg is "; msg
'             if msg.GetField() = "position" then
'                     ' keep track of where we reached in content
'                     curPos = msg.GetData() 
'                     ' check for mid-roll ads
'                     adPods = RAF.getAds(msg)
'                     if adPods <> invalid and adPods.count() > 0
'                         print "PlayerTask: mid-roll ads, stopping video"
'                         'ask the video to stop - the rest is handled in the state=stopped event below
'                         video.control = "stop"  
'                     end if
'                 else if msg.GetField() = "state" then
'                     curState = msg.GetData()
'                     print "PlayerTask: state = "; curState
'                     if curState = "stopped" then
'                         if adPods = invalid or adPods.count() = 0 then 
'                             exit while
'                         end if

'                         print "PlayerTask: playing midroll/postroll ads"
'                         keepPlaying = RAF.showAds(adPods, invalid, view)
'                         adPods = invalid
'                         if isPlayingPostroll then 
'                             exit while
'                         end if
'                         if keepPlaying then
'                             print "PlayerTask: mid-roll finished, seek to "; stri(curPos)
'                             video.visible = true
'                             video.seek = curPos
'                             video.control = "play"
'                             video.setFocus(true) 'important: take the focus back (RAF took it above)
'                         end if
                            
'                     else if curState = "finished" then
'                         print "PlayerTask: main content finished"
'                         ' render post-roll ads
'                         adPods = RAF.getAds(msg, invalid, view)
'                         if adPods = invalid or adPods.count() = 0 then 
'                             exit while
'                         end if
'                         print "PlayerTask: has postroll ads"
'                         isPlayingPostroll = true
'                         ' stop the video, the post-roll would show when the state changes to  "stopped" (above)
'                         m.video.control = "stop"
'                         end if
'                 end if
'             end if
'     end while
'     end sub
    '     while playContent
    '     msg = wait(0, m.port)
    '     msgType = type(msg)

    '         if msgType = "roSGNodeEvent"
    '             if (msg.GetNode() = "myVideo")
    '                 print "GetField is " msg.GetField()
    '                 if msg.GetField() = "position" then
    '                     curPos = m.video.position
    '                     videoEvent = createPlayPosMsg(curPos)
    '                     adPods = RAF.getAds(videoEvent)
    '                         if adPods <> invalid and adPods.count() > 0
    '                             m.video.control = "stop"
    '                             playContent = adIface.showAds(adPods)
    '                             if playContent then
    '                                 m.video.seek = curPos
    '                                 m.video.control = "play"
    '                                 end if
    '                             end if                    
    '                             else if msg.getState() = "state" then
    '                                 curState = m.video.state
    '                                 if curState = "finished" then
    '                                     videoEvent = createPlayPosMsg(curState, true)
    '                                     RAF.getAds(videoEvent)
    '                                     m.video.control = "stop"
    '                                     if adPods <> invalid and adPods.count() > 0
    '                                         RAF.showAds(adPods)
    '                                     end if
    '                                 end if
    '                             end if
    '                     end if
    '                 end if
    '             end if
    '     end while


    '     function createPlayPosMsg(position as Integer, completed = false as Boolean, started = false as Boolean) as Object
    '         videoEvent = { pos: position,
    '                     done: completed,
    '                     started: started,
    '                     isStreamStarted : function () as Boolean
    '                                             return m.started
    '                                         end function,
    '                     isFullResult : function () as Boolean
    '                                             ' true = video playback is complete
    '                                         return m.done
    '                                     end function,
    '                     isPlaybackPosition : function () as Boolean
    '                                                 ' true if current position in the video has changed
    '                                                 return true
    '                                             end function,
    '                     isStatusMessage : function () as Boolean
    '                                             ' true if status info is available
    '                                             return (m.done or m.started)
    '                                         end function,
    '                     getIndex : function () as Integer
    '                                         ' returns segment start time in seconds
    '                                     return m.pos
    '                                 end function,
    '                     getMessage : function () as String
    '                                         result = ""
    '                                         if m.done
    '                                             result = "end of stream"
    '                                         else if m.started
    '                                             result = "start of play"
    '                                         end if
    '                                         return result
    '                                     end function
    '                     }
    '         return videoEvent
    '     end function