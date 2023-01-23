/*
Google search the highlighted text
*/
#f::
    Send ^c
    Run, chrome.exe --profile-directory="%chrome_personal_profile_directory%" "http://www.google.com/search?hl=en&q=%Clipboard%"
    return