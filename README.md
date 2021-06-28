# Tools And Documentation To Automate And Manage Windows Deployment

These instructions are for creating a customized Windows 10 environment that can be easily installed onto PCs through an automated, bootable USB installer.  The instructions are precise and detailed so anyone with general experience using Windows should be able to follow this process, while experienced system administrators can customize settings as desired.  Finally, while the process to create the USB installer takes many steps, the end result will be a tool that can be used to configure a Windows PC in minutes instead of hours.

## Recommended Minimum PC Requirements

* 64-bit UEFI
* Windows 10 Professional 21H1 64-bit
* 8GB of RAM
* 60GB of free disk space
* An active network connection with Internet access
* Empty USB flash drive with 16-32GB capacity

Before beginning, it is critical to ensure that your computer's time zone and date and time settings are correct.  Please note that having a computer with a fast processor, solid state disk, and lots of RAM will make this process faster.  Additionally, USB flash drives with more than 32GB of capacity cannot easily be formatted to be bootable with Windows.  A fast USB 3.0 32GB flash drive is highly recommended.

## Part 1 - Download Windows 10

1.   On a Windows 10 Professional computer running Windows version 21H1 64-bit, go to Microsoft's Download Windows 10 page (currently available at <https://www.microsoft.com/en-us/software-download/windows10>).
2.   Download the Create Windows 10 installation media tool (currently MediaCreationTool21H1.exe available from <https://go.microsoft.com/fwlink/?LinkId=691209>).
3.   Run the downloaded tool.  In the User Account Control window that appears, click **Yes**.
4.   In the Windows 10 Setup window that appears, click **Accept**.
5.   On the What do you want to do? screen, select **Create installation media (USB flash drive, DVD, or ISO file) for another PC**.
6.   Click **Next**.
7.   On the Select language, architecture, and edition screen, uncheck **Use the recommended options for this PC**.
8.   Set the Language field to **English (United States)**, set the Edition field to **Windows 10**, set the Architecture to **Both**.
9.   Click **Next**.
10.  On the Choose which media to use screen, select **ISO file**.
11.  Click **Next**.
12.  In the Select a path window that appears, open the **Documents** folder for your Windows user account, and enter `Windows21H1.iso` in the File name field, then click **Save**.
13.  The computer will download the ISO file (this may take several minutes).
14.  When the download is complete, click **Finish**.

## Part 2 - Download Windows ADK

1.   Go to Microsoft's Download and install the Windows ADK page (currently available at <https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install>).
2.   Download the Windows ADK for Windows 10, version 2004 (currently available from <https://go.microsoft.com/fwlink/?linkid=2120254>).
3.   Download the Windows PE add-on for the ADK, version 2004 (currently available from <https://go.microsoft.com/fwlink/?linkid=2120253>).
4.   Run the adksetup.exe tool.  In the installation window that appears, click **Next**.
5.   Click **No** then click **Next**.
6.   Click **Accept**.
7.   Check all the installable features and click **Install**.
8.   In the User Account Control window that appears, click **Yes**.
9.   When the installation process is complete, click **Close**.
10.  Run the **adkwinpesetup.exe** tool.  In the installation window that appears, click **Next**.
11.  Click **Next**.
12.  Click **Accept**.
13.  Click **Install**.
14.  In the User Account Control window, click **Yes**.
15.  When the installation is complete, click **Close**.

## Part 3 - Install VirtualBox

1.   Go to <https://www.virtualbox.org>.
2.   Click the [**Downloads**](https://www.virtualbox.org/wiki/Downloads) link in the navigation menu.
3.   Click the link to download VirtualBox for [**Windows hosts**](https://download.virtualbox.org/virtualbox/6.1.22/VirtualBox-6.1.22-144080-Win.exe) and save the download on your computer (at the time of publication, the latest version of VirtualBox is 6.1.22).
4.   Run the **VirtualBox-6.1.22-144080-Win.exe** installer.
5.   In the Oracle VM VirtualBox 6.1.22 Setup window that appears, click **Next**.
6.   Click **Next**.
7.   On the second Custom Setup screen, configure the options as preferred (suggested settings: Create start menu entries and Register file associations are checked, Create a shortcut on the desktop and Create a shortcut in the Quick Launch Bar are unchecked) and click **Next**.
8.   On the Warning: Network Interfaces screen, click **Yes**.
9.   On the Ready to Install screen, click **Install**.
10.  In the User Account Control window that appears, click **Yes**.
11.  In the Windows Security window that appears, ensure that **Always trust software from "Oracle Corporation"** is checked and click **Install**.
12.  Once the installation is complete, ensure that Start Oracle VM VirtualBox 6.1.22 after installation is checked, then click **Finish**.
13.  In the Oracle VM VirtualBox Manager application that appears, open the **File** menu and click **Preferences...**.
14.  In the VirtualBox - Preferences window, click on **Update** in the left column, uncheck **Check for Updates** and click **OK**.

## Part 4 - Configure EFI 64 Bit Virtual Machine

1.   In the Oracle VM VirtualBox Manager application, click the **New** button.
2.   Click the **Expert Mode** button.
3.   In the Create Virtual Machine window that appears, in the Name field, enter `Windows20H2ProEFI64`.
4.   Select **Windows 10 (64-bit)** for Version, set Memory size to `4096` (or larger if your computer host computer has more than 8GB RAM).
5.   Click the **Create** button.
6.   In the Create Virtual Hard Disk window, click **Create**.
7.   In the Oracle VM VirtualBox Manager window, click **Settings**.
8.   In the Windows20H2ProEFI64 - Settings window, click on **System** in the left column.
9.   On the Motherboard tab of System, set Pointing Device to **PS/2 Mouse**, and check **Enable EFI (special OSes only)**.
10.  Click on **Storage** in the left column.
11.  In the Storage Devices pane, click on the **Empty** optical drive.
12.  In the Attributes area on the right side of the window, click on the disc icon to the right of the Optical Drive pull down menu, then click **Choose a disk file...**.
13.  In the file browser that appears, select the **Windows20H2.iso** file you downloaded and click **Open**.
14.  In the Windows20H2ProEFI64 - Settings window, under Storage Devices, click **Controller: SATA**.
15.  At the bottom of the Storage Devices list, click the **Adds a new storage attachment** button (the blue square button with a green plus sign).
16.  Click **Hard Disk**.
17.  In the Windows20H2ProEFI64 - Hard Disk Selector window, click **Create**.
18.  In the Create Virtual Hard Disk window that appears, click the radio button to select **VHD (Virtual Hard Disk)**.
19.  Click **Next**.
20.  Click **Next**.
21.  Click **Create**.
22.  In the Windows20H2ProEFI64 - Hard Disk Selector window, click **Choose**.
23.  Click **Audio** in the left column.
24.  Uncheck **Enable Audio**.
25.  Click **Network** in the left column.
26.  Uncheck **Enable Network Adapter**.
27.  Click **USB** in the left column.
28.  Uncheck **Enable USB Controller**.
29.  Click the **OK** button in the lower-right corner to complete configuration of the virtual machine.

## Part 5 - Boot The Windows Installer In The Virtual Machine

1.   In the Oracle VM VirtualBox Manager window, click **Start** to start the virtual machine.
2.   Wait a few moments.  The virtual machine will display several messages, then will boot into the UEFI Interactive Shell v2.2.
3.   At the top of the Windows20H2ProEFI64 \[Running\] virtual machine window, there will be a notification that "You have the Auto capture keyboard option turned on."  Click the **Do not show this message again** icon (the right-most text bubble strike through icon on the message) to disable this notification.
4.   At the Shell> prompt, type `exit` and press the **Enter** key.
5.   On the system screen that appears, press the **Down Arrow** key 3 times to select **Boot Maintenance Manager** and press the **Enter** key.
6.   Press the **Up Arrow** key to select **\[0\]** in the Auto Boot Time-out field.
7.   Press the **Enter** key.
8.   Type `5` and press the **Enter** key.
9.   Press the **Esc** key, then press the **Y** key.
10.  Press the **Down Arrow** key to select **Continue**.
11.  This and the next two steps are time sensitive.  Press the **Enter** key.
12.  When the Press any key to boot from CD or DVD message appears, press the **A** key.
13.  The Windows Boot Manager screen should appear.  **Windows 10 Setup (64-bit)** should be selected.  Press **Enter**.
14.  The Windows Setup tool will load.  At the top of the window, there will be a notification about mouse pointer integration.  Click the **Do not show this message again** icon (the right-most text bubble strike through icon on the message) to disable this notification.
15.  Click the mouse in the center of the Windows20H2ProEFI64 \[Running\] window.
16.  A message about the host key and mouse and keyboard capture will appear.  Read it, then check the **Do not show this message again** box and click **Capture**.
17.  Until noted, the following procedure applies to actions inside the virtual machine environment.

## Part 6 - Install Windows In The Virtual Machine

1.   On the first Windows Setup screen, click the **Next** button.
2.   Click **Install now**.
3.   On the Activate Windows screen, click the **I don't have a product key** link.
4.   On the Select the operating system you want to install screen, select **Windows 10 Pro** and click the **Next** button.
5.   On the Applicable notices and license terms screen, check **I accept the license terms** and click **Next**.
6.   On the Which type of installation do you want screen, click **Custom: Install Windows only (advanced)**.
7.   Ensure that **Drive 0 Unallocated Space** is selected, then click **Next**.
8.   The Windows installation will begin.  Please wait while files are copied to the virtual machine's disk.  The virtual machine will automatically restart.
9.   Eventually, the Let's start with region screen will appear.

## Part 7 - Enable Windows Audit Mode

1.   To bypass the Windows configuration wizard and enter Audit Mode, press and hold the **Control** and **Shift** keys at the same time, then press the **F3** key (for a moment, all three keys should be pressed at the same time).  Release all the keyboard keys.
2.   The virtual machine will restart and will log the built-in Administrator account into Windows in Audit Mode.
3.   When Audit Mode starts, the system will automatically launch the System Preparation Tool 3.14 graphical interface.  Click **Cancel** to close the tool.
4.   Importantly, please note that Parts 8-15 must be completed without shutting down or restarting the virtual machine, as Windows will only allow customization of certain settings on the first boot.

## Part 8 - Configure Control Panels

1.   Right-click on the **Start** button in the lower-left corner of the screen and click **Run**.
2.   In the Open field, type `control panel` and press the **Enter** key.
3.   In the upper-right corner of the Control Panel window that appears, click on the **View by** pull down menu and click **Large icons** to switch from the Category option to Large icons.
4.   Click **Date and Time**, click **Change time zone...** select **(UTC-05:00) Eastern Time (US & Canada)** (or select the appropriate time zone for your location) and click the **OK** button.
5.   In the Date and Time window, uncheck **Notify me when the clock changes** and click the **OK** button.
6.   Click **File Explorer Options**.
7.   Change Open File Explorer to **This PC**.
8.   Uncheck **Show recently used files in Quick access**.
9.   Uncheck **Show frequently used folders in Quick access**.
10.  Click the **Clear** button.
11.  Click the **View** tab at the top of the File Explorer Options window.
12.  In the Advanced settings list, uncheck **Hide extensions for known file types**.
13.  Scroll down in the Advanced settings list and uncheck **Use Sharing Wizard (Recommended)**.
14.  Click the **OK** button to close the File Explorer Options window.
15.  Click **Network and Sharing Center**.
16.  In the left column of the Network and Sharing window, click **Change advanced sharing settings**.
17.  In the Advanced sharing settings window, expand the **Private** section (click on the arrow to the right of the section heading) and uncheck **Turn on automatic setup of network connected devices**.
18.  Click the radio button to select **Turn off network discovery** and click the **Save changes** button.
19.  In the left column of the Network and Sharing Center window, click **Control Panel Home**.
20.  Click **Power Options**.
21.  To the right of Balanced (recommended) click **Change plan settings**.
22.  Click **Change advanced power settings**.  Please note that different options may be available in this section depending upon whether your host device has battery power (e.g., a tablet or notebook computer) or if it is a desktop.  In some cases, there may be both On battery and Plugged in options available for settings.  In these cases, set all settings to the values indicated.
23.  In the Power Options window that appears, ensure that **Hard disk** is expanded and under that, **Turn off hard disk after** is expanded, and set all settings to `0/Never`.
24.  Double-click **Internet Explorer**, double-click **JavaScript Timer Frequency**, and set all settings to **Maximum Performance**.
25.  If available, double-click **Desktop background settings**, double-click **Slide show**, and set all settings to **Paused**.
26.  If available, double-click **Wireless Adapter Settings**, double-click **Power Saving Mode**, and set all settings to **Maximum Performance**.
27.  If available, double-click **Sleep**, double-click **Allow wake timers**, and set all settings to **Enable**.
28.  Double-click **USB settings**, double-click **USB selective suspend setting**, and set all settings to **Disabled**.
29.  If available, double-click **Power buttons and lid**, double-click **Power buton action**, and set all settings to **Shut down**.  If available, double-click **Sleep button action** and set all settings to **Do nothing**. 
30.  Double-click **PCI Express**, double-click **Link State Power Management**, and set all settings to **Off**.
31.  Double-click **Display**, double-click **Turn off display after**, and set all settings to `10` Minutes.
32.  Double-click **Multimedia settings**.  Double-click **When sharing media** and set all settings to **Prevent idling to sleep**.  Double-click **Video playback quality bias** and set all settings to **Video playback performance bias**.  Double-click **When playing video** and set all settings to **Optimize video quality**.
33.  Click the **OK** button.
34.  Click the **Back to Power Options** back arrow button in the upper-left corner of the Edit Plan Settings window.
35.  Click **Control Panel Home**.
36.  Click **Sound**.
37.  In the Sound window, go to the **Sounds** tab.
38.  Change Sound Scheme to **No Sounds**, then click the **OK** button.
39.  Click the **Close (X)** button in the upper-right corner of the All Control Panel Items window to close the window.

## Part 9 - Configure Settings

1.   Click on the **Start** button in the lower-left corner of the screen, then **Settings** (gear icon).
2.   Go to **Personalization**.
3.   Go to **Colors**.
4.   Scroll down and set **Choose your default app mode** to **Dark**.
5.   Turn **Transparency effects** **Off**.
6.   Go to **Background**.
7.   Set **Background** to **Solid color**.
8.   Go to **Lock screen**.
9.   Set **Background** to **Picture**.
10.  Set **Get fun facts, tips, and more from Windows and Cortana on your lock screen** to **Off**.
11.  Go to **Start**.
12.  Turn **Show recently added apps** **Off**.
13.  Turn **Show suggestions occasionally in Start** **Off**.
14.  Turn **Show recently opened items in Jump Lists on Start or the taskbar and in File Explorer Quick Access** **Off**.
15.  Go to **Taskbar**.
16.  Turn **Show badges on taskbar buttons** **Off**.
17.  Click **Select which icons appear on the taskbar**.
18.  Turn **Always show all icons in the notification area** **On**.
19.  In the upper-left corner of the window, click the **Back** arrow button (the button may be hidden until the mouse cursor is placed over it, to the left of Settings in the window's title bar).
20.  Go to **Turn system icons on or off**.
21.  Set  **Input indicator**, **Location**, **Action Center**, **Microphone** to **Off**.
22.  In the upper-left corner of the window, click the **Back** arrow button (the button may be hidden until the mouse cursor is placed over it, to the left of Settings in the window's title bar).
23.  Go to **Themes**.
24.  Click **Save theme**.
25.  In the Save your theme popup that appears, in the Name your theme field, enter `Default` and click the **Save** button.
26.  In the upper-left corner of the window, click the **Home** button.
27.  Click **System**.
28.  On the right side of the window, under Scale and layout set **Change the size of text, apps, and other items** to **100%**.
29.  Click **Notifications & actions**.
30.  Click **Edit your quick actions**.
31.  Click the pin strikethrough icon on **Tablet Mode**, **Location**, **Connect**, **Project**, **VPN** to remove them each from the quick actions tiles.
32.  Click **Done**.
33.  Click back in the Settings window to close the Action Center.
34.  Uncheck **Allow notifications to play sounds**.
35.  Uncheck **Show me the Windows welcome experience after updates and occasionally when I sign in to highlight what's new and suggested**.
36.  Uncheck **Suggest ways I can finish setting up my device to get the most out of Windows**.
37.  Uncheck **Get tips, tricks, and suggestions as you use Windows**.
38.  Click **Focus assist**.
39.  Turn **When I'm playing a game** **Off**.
40.  Turn **When I'm using an app in full screen mode** **Off**.
41.  Click **Tablet**.
42.  Set **When I sign in** to **Never use tablet mode**.
43.  Click **Change additional tablet settings**.
44.  Turn **Hide app icons on the taskbar** **Off**.
45.  Turn **Make app icons on the taskbar easier to touch** **Off**.
46.  Turn **Make buttons in File Explorer easier to touch** **Off**.
47.  In the upper-left corner of the window, click the **Back** arrow button (the button may be hidden until the mouse cursor is placed over it, to the left of Settings in the window's title bar).
48.  Click **Multitasking**.
49.  Set **Show suggestions in your timeline** to **Off**.
50.  Click **Shared experiences**.
51.  Turn **Let apps on other devices (including linked phones and tablets) open and message apps on this device, and vice versa** **Off**.
52.  In the upper-left corner of the window, click **Home**.
53.  Click **Devices**.
54.  Click **Printers & scanners**.
55.  Uncheck **Let Windows manage my default printer**.
56.  Click **AutoPlay**.
57.  Turn **Use AutoPlay for all media and devices** **Off**.
58.  Click **Home**.
59.  Click **Apps**.
60.  Click on and **Uninstall** the following apps in the list: **3D Viewer**, **Feedback Hub**, **Groove Music**, **Mail and Calendar**, **Microsoft Solitaire Collection**, **Mixed Reality Portal**, **Movies & TV**, **Office**, **OneNote**, **Paint 3D**, **Skype**, **Tips**, **Weather**, **Xbox**, **Xbox Live**.
61.  Click **Offline Maps**.
62.  Click **Delete all maps** and click **Delete all** in the popup that appears.
63.  Set **Automatically update maps** to **Off**.
64.  Click on **Apps for websites**.
65.  Set **Maps** (there may be two Maps listed, set them both) to **Off**.
66.  Click **Video playback**.
67.  If there is an option for **When watching movies and videos on battery power**, set it to **Optimize for video quality**.
68.  Click **Startup**.
     Set **Microsoft OneDrive (32 bit) Setup** to **Off**.
69.  Set **Windows Security notification icon** to **Off**.
70.  Click **Home**.
71.  Click **Gaming**.
72.  Turn **Enable Xbox Game Bar for things like recording game clips, chatting with friends, and receiving game invites.** **Off.**
73.  Uncheck **Open Game bar using this button on a controller**.
74.  Click **Game Mode**.
75.  Turn **Game Mode** **Off**.
76.  Click **Home**.
77.  Click **Search**.
78.  Set **Allow Windows Search to provide results from the apps and services that you are signed in to with your Microsoft account.** **Off**.
79.  Set **Allow Windows Search to provide results from the apps and services that you are signed in to with your work or school account.** **Off**.
80.  Set **To improve your search suggestions, let Windows Search store your search history locally on this device.** **Off**.
81.  Click **Clear device search history**.
82.  Click **Home**.
83.  Click **Privacy**.
84.  Set **Let websites provide locally relevant content by accessing my language list**, **Let Windows track app launches to improve Start and search results**, **Show me suggested content in the Settings app** to **Off**.
85.  Click **Inking & typing personalization**.
86.  Set **Getting to know you** **Off**.
87.  Click **Diagnostics & feedback**.
88.  Click **Delete** to delete the diagnostic data from the system.
89.  Set **Windows should ask for my feedback** to **Never**.
90.  Click **Activity History**.
91.  Uncheck **Store my activity history on this device**.
92.  Click **Clear** to clear the activity history, then click **Ok** in the popup that appears.
93.  Click **Location**.
94.  Click **Clear** to clear the location history from the system.
95.  Click **Microphone**.
96.  Set microphone access for **Cortana** to **Off**.
97.  Click **Voice activation**.
98.  Set **Choose your default app for headset button press** to **Off**.
99.  Set **Allow apps to use voice activation when this device is locked** to **Off**.
100. Set **Allow apps to use voice activation** to **Off**.
101. Click **Notifications**.
102.  Set **Allow apps to access your notifications** to **Off**.
103. Click **Change** to change notification access and set **User notification access for this device** to **Off** in the popup, then click in the Notifications settings window to close the popup.
104. Click **Account info**.
105. Set **Allow apps to access your account info** to **Off**.
106. Click **Change** to change account info access for the device and set **Account info access for this device** to **Off** in the popup, then click in the Account info settings window to close the popup.
107. Click **Contacts**.
108. Set **Allow apps to access your contacts** to **Off**.
109. Click **Change** to change contacts access for the device and set **Contacts access for this device** to **Off** in the popup, then click in the Contacts settings window to close the popup.
110. Click **Calendar**.
111. Set **Allow apps to access your calendar** to **Off**.
112. Click **Change** to change calendar access for the device and set **Calendar access for this device** to **Off** in the popup, then click in the Calendar settings window to close the popup.
113. Click **Phone calls**.
114. Set **Allow apps to make phone calls** to **Off**.
115. Click **Change** to change phone call access for the device and set **Phone call access for this device** to **Off** in the popup, then click in the Phone calls settings window to close the popup.
116. Click **Call History**.
117. Set **Allow apps to access your call history** to **Off**.
118. Click **Change** to change call history access for the device and set **Call history access for this device** to **Off** in the popup, then click in the Call history settings window to close the popup.
119. Click **Email**.
120. Set **Allow apps to access your email** to **Off**.
121. Click **Change** to change email access for the device and set **Email access for this device** to **Off** in the popup, then click in the Email settings window to close the popup.
122. Click **Tasks**.
123. Set **Allow apps to access your tasks** to **Off**.
124. Click **Change** to change tasks access for the device and set **Tasks access for this device** to **Off** in the popup, then click in the Tasks settings window to close the popup.
125. Click **Messaging**.
126. Set **Allow apps to read or send messages** to **Off**.
127. Click **Change** to change messaging access for the device and set **Messaging access for this device** to **Off** in the popup, then click in the Messaging settings window to close the popup.
128. Click **Radios**.
129. Set **Allow apps to control device radios** to **Off**.
130. Click **Change** to change access to control radios for the device and set **Access to control radios on this device** to **Off** in the popup, then click in the Radios settings window to close the popup.
131. Click **Other devices**.
132. Set **Communicate with unpaired devices** to **Off**.
133. Click **Background apps**.
134. In the Choose which apps can run in the background section, set background processing for all apps listed to **Off**.
135. Set **Let apps run in the background** to **Off**.
136. Click **App diagnostics**.
137. Set **Allow apps to access diagnostic info about your other apps** to **Off**.
138. Click **Change** to change app diagnostic info access for the device and set **App diagnostic access for this device** to **Off** in the popup, then click in the App diagnostics settings window to close the popup.
139. Click **Documents**.
140. Set document library access for **Voice Recorder** to **Off**.
141. Click **Pictures**.
142. In the Choose which apps can access your pictures library, set pictures access for all apps to **Off**.
143. Set **Allow apps to access your pictures library** to **Off**.
144. Click **Change** to change pictures library access for the device and set **Pictures library access for this device** to **Off** in the popup, then click in the Pictures settings window to close the popup.
145. Click **Videos**.
146. In the Choose which apps can access your videos library, set video library access for all apps to **Off**.
147. Set **Allow apps to access your videos library** to **Off**.
148. Click **Change** to change videos library access for this device and set **Videos library access for this device** to **Off** in the popup, then click in the Videos settings window to close the popup.
149. Click **File system**.
150. Set **Allow apps to access your file system** to **Off**.
151. Click **Change** to change file system access for the device and set **File system access for this device** to **Off** in the popup, then click in the File system settings window to close the popup.
152. Click **Home**.
153. Click **Update & Security**.
154. Click **Delivery Optimization**.
155. Set **Allow downloads from other PCs** to **Off**.
156. Click **Troubleshoot**.
157. Set **Recommended troubleshooting** to **Don't run any troubleshooters**.
158. Close the Settings window by clicking the **Close (X)** button in the upper-right corner of the window (the button may be hidden until the mouse cursor is placed over it).

## Part 10 - Enable Additional Windows Features

1.   Right-click on the **Start** button in the lower-left corner of the screen and select **Windows PowerShell (Admin)**.
2.   In the PowerShell window that appears, to enable Microsoft Hyper-V, enter `dism /online /enable-feature /featurename:microsoft-hyper-v /norestart /all` and press the **Enter** key.
3.   To enable Winodws Sandbox, enter `dism /online /enable-feature /featurename:containers-disposableclientvm /norestart /all` and press the **Enter** key.
4.   Optionally, to enable the older .Net 3.5 framework (please note that this should only be enabled if it is a requirement), enter `dism /online /enable-feature /featurename:netfx3 /limitaccess /source:d:\x64\sources\sxs /norestart /all` and press the **Enter** key.
5.   Optionally, to enable the older SMB1 protocol (please note that enabling the SMB1 protocol can be a security risk and this step should be skipped unless it is a requirement), enter `dism /online /enable-feature /featurename:smb1protocol /norestart` and press the **Enter** key.  After the feature is enabled, enter `dism /online /disable-feature /featurename:smb1protocol-deprecation /norestart` and press the **Enter** key.   After the feature is disabled, enter `dism /online /disable-feature /featurename:smb1protocol-server /norestart` and press the **Enter** key.
6.   Type `del (get-psreadlineoption).historysavepath` and press the **Enter** key.
7.   Click the **Close (X)** button in the upper-right corner of the Administrator: Windows PowerShell window (the button may be hidden until the mouse cursor is placed over it).

## Part 11 - Disable Server Service

1.   Right-click on the **Start** button in the lower-left corner of the screen and click **Computer Management**.
2.   In the Computer Management window, in the left column, under Computer Management (Local), double-click **Services and Applications** to expand it.
3.   Double-click on **Services**, then, in the Services pane in the middle of the window, scroll down to the service named Server and double click on **Server** to open the Server service.
4.   In the Server Properties (Local Computer) window that appears, switch the Startup type pull down menu to **Disabled**, then click the **Stop** button.
5.   Wait for the service to stop, then click the **OK** button to close the Server Properties (Local Computer) window.
6.   In the Computer Management window, click the **File** menu, then click **Exit** to close the Computer Management window.

## Part 12 - Configure Group Policies

1.   Right-click on the **Start** button in the lower-left corner of the screen and click **Run**.
2.   In the Run window that appears, in the Open field, type `gpedit.msc` and press the **Enter** key.
3.   In the Local Group Policy Editor window that appears, in the left column, under Local Computer Policy, Computer Configuration, double-click on **Administrative Templates** to expand it.
4.   Under the expanded Administrative Templates section in the left column, double-click **Windows Components** to expand it.
5.   Double-click **AutoPlay Policies**.
6.   In the AutoPlay Policies pane on the right of the window, double-click **Turn Off AutoPlay**.
7.   In the Turn Off AutoPlay window that appears, click the radio button to select **Enabled** then click the **OK** button (it may be necessary to resize and move the Turn off Autoplay window to reach the OK button).
8.   In the Local Group Policy Editor, in the left column, under Local Computer Policy, Computer Configuration, Administrative Templates, Windows Components, click **BitLocker Drive Encryption**.
9.   In the BitLocker Drive Encryption pane on the right of the window, double-click **Choose drive encryption method and cipher strength (Windows 10 \[Version 1511\] and later)** (it may be necessary to maximize the windows size, expand the size of the Setting column, or hover the mouse cursor over the setting name to get a pop up to be able to determine which of the 3 similarly-named settings is the right one).
10.  In the Choose drive encryption method and cipher strength (Windows 10 \[Version 1511\] and later) window that appears, click the radio button next to **Enabled**.
11.  In the Options pane in the lower-left of the window, set the **Select the encryption method for operating system drives** setting to **XTS-AES 256-bit**.
12.  Set the **Select the encryption method for fixed data drives** setting to **XTS-AES 256-bit**.
13.  Set the **Select the encryption method for removable data drives** setting to **AES-CBC 256-bit**.
14.  Click the **OK** button (it may be necessary to resize and move the window to reach the OK button).
15.  In the Local Group Policy Editor, in the left column, under Local Computer Policy, Computer Configuration, Administrative Templates, Windows Components, click **Credential User Interface**.
16.  In the Credential User Interface pane on the right side of the window, double-click **Prevent the use of security questions for local accounts**.
17.  In the Prevent the use of security questions for local accounts window that appears, click the **Enabled** radio button.
18.  Click the **OK** button.
19.  In the Local Group Policy Editor, in the left column, under Local Computer Policy, Computer Configuration, Administrative Templates, Windows Components, scroll down until Windows Update is visible (it may be necessary to maximize the window size and/or expand the left pane of the window to see read the names of the folders listed) and double-click **Windows Update**.
20.  In the Windows Update pane on the right of the window, double-click **Configure Automatic Updates**.
21.  In the Configure Automatic Updates window that appears, click the radio button to select **Disabled** then click the **OK** button.
22.  In the Local Group Policy Editor, in the left column, under Local Computer Policy, User Configuration, double-click **Administrative Templates**, then double-click **Start Menu and Taskbar**.
23.  In the Start Menu and Taskbar pane on the right of the window, scroll down to find Remove the Meet Now icon and double-click **Remove the Meet Now icon**.
24.  In the Remove the Meet Now icon window that appears, click the radio button to select **Enabled**.
25.  Click the **OK** button.
26.  In the Local Group Policy Editor window, click the **File** menu, then click **Exit** to close the Local Group Policy Editor.

## Part 13 - Rename The Boot Volume

1.   Right-click on the **Start** button in the lower-left corner of the screen and click **File Explorer**.
2.   Right-click on **Local Disk (C:)** and click **Rename**.
3.   Enter the drive name `Windows` and press the **Enter** key.
4.   Click the **File** menu in the upper-left corner of the screen, then click **Close**.

## Part 14 - Customize Destop, Taskbar, Start Menu, And Internet Explorer

1.   Right-click on the **Microsoft Edge** shortcut on the Desktop and click **Delete**.
2.   Right-click on an empty area of the Taskbar (e.g., 2/3 of the way from the bottom-left of the screen to the bottom-right of the screen on an empty black area between the Microsoft Store icon and the System Tray).
3.   In the context menu that appears, click to uncheck **Show Cortana button**.
4.   Right-click on an empty area of the Taskbar again.
5.   Click on **Search**, then click **Show search icon**.
6.   Right-click on the **Microsoft Store** icon on the Taskbar, then click **Unpin from taskbar**.
7.   Click on the **Start** button in the lower-left corner of the screen.
8.   On the right side of the Start menu, right-click on **Productivity**, then click **Unpin group from Start**.
9.   Right-click on **Explore**, then click **Upin group from Start**.
10.  Click on the **Start** button in the lower-left corner of the screen.
11.  In the Application List on the left side of the Start Menu, right-click on **Calculator**.
12.  Click **Pin to Start**.
13.  Right-click on the **Calculator** tile on the right side of the Start Menu and click **More**, then click **Turn Live Tile off**.
14.  Right-click on the **Calculator** tile on the right side of the Start Menu and click **Resize**, then click **Small**.
15.  Scroll in the Application List on the left side of the Start Menu down to Windows Accessories and click on **Windows Accessories**.
16.  Click on **Internet Explorer**.
17.  In the Internet Explorer 11 window that appears, click the radio button to select **Don't use recommended settings** and click the **OK** button.
18.  Click on the **Tools** (gear icon) menu in the upper-right corner of the Internet Explorer window and click **Internet options**.
19.  In the Internet Options window that appears, in the Home page field, erase the URL listed and enter `about:blank`.
20.  Click the **Tabs** button and in the Tabbed Browsing Settings window that appears, change the **When a new tab is opened, open:** field to **A blank page** and click the **OK** button.
21.  Back in the Internet Options window, click the **OK** button.
22.  Click the **View favorites, feeds, and history** (star) icon in the upper-right of the Internet Explorer window.
23.  Right-click on the **Bing** icon and click **Delete**.
24.  Click on the **Tools** (gear icon) menu in the upper-right corner of the Internet Explorer window and click **Safety** then click **Delete browsing history...**.
25.  Uncheck **Preserve Favorites website data** and check **Download History**, **Form data**, **Passwords**, and **Tracking Protection, ActiveX Filtering and Do Not Track** and click the **Delete** button.
26.  Close the Internet Explorer window by clicking the **Close (X)** button in the upper-right corner of the window.
27.  When prompted, click **Close all tabs**.
28.  Click the Start icon in the lower-left corner of the screen, scroll down the Application List on the left side of the Start Menu and click on **Windows Accessories**, and click **Internet Explorer**.
29.  Close the Internet Explorer window by clicking the X close button in the upper-right corner of the window.
30.  When prompted, click **Close all tabs**.
31.  Click the Start icon in the lower-left corner of the screen, scroll down the Application List on the left side of the Start Menu and click on **Windows Accessories**, and click **Internet Explorer**.
32.  Close the Internet Explorer window by clicking the **Close (X)** button in the upper-right corner of the window.
33.  Right-click on **Recycle Bin** on the Desktop and click **Empty Recycle Bin**.
34.  Click **Yes** to confirm deletion.

## Part 15 - Restart The Virtual Machine

1.   Click the **Start** button in the lower-left corner of the screen, click the **Power** button, and click **Restart**.
2.   The system may restart one or more times and will eventually restart in Audit Mode.
3.   When Audit Mode starts, the system will automatically launch the System Preparation Tool 3.14 graphical interface.  Click **Cancel** to close the tool.

## Part 16 - Clean Up The Virtual Disk

1.   Right-click on the **Start** button in the lower-left corner of the screen, then click **Run**.
2.   In the Open field, type `cleanmgr` and press the **Enter** key.
3.   In the Disk Cleanup for Windows (C:) window that eventually appears, click the **More Options** tab.
4.   In the System Restore and Shadow Copies section, click **Clean up...**.
5.   Click **Delete** when prompted.
6.   Click the **Disk Cleanup** tab in the Disk Cleanup for Windows (C:) window.
7.   Ensure that all options in the Files to delete list are checked, then click **OK**.
8.   Click **Delete Files** when prompted.  Wait a few moments while the system cleans the virtual disk.
9.   Click the **Start** button in the lower-left corner of the screen, click the **Power** button, and click **Shut down**.
10.  Until noted, the following procedure applies to actions inside the host environment.

## Part 17 - Export The Virtual Machine

1.   In the Oracle VM VirtualBox Manager window, click **Settings**.
2.   In the Windows20H2ProEFI64 - Settings window, in the left column, click **Storage**.
3.   In the Storage Devices list, click **Windows20H2.iso**.
4.   To the right of the Optical Drive menu, click the **Choose a virtual optical disk or a physical drive to use with the virtual drive** (blue disc) button.
5.   Click **Remove Disk from Virtual Drive**.
6.   Click **OK**.
7.   In the Oracle VM VirtualBox Manager window, click the **File** menu, then click **Export Appliance...**.
8.   In the Export Virtual Appliance window, click **Next**.
9.   Note the location and file name in the File field, then click **Next**.
10.  Click **Export**.  VirtualBox will export the virtual machine to an appliance file (this may take several minutes).

## Part 18 - Capture An Image Of The Audit Mode Virtual Machine

1.   Once VirtualBox has completed exporting the virtual machine, in the Oracle VM VirtualBox Manager window, click **Settings**.
2.   In the Windows20H2ProEFI64 - Settings window, in the left column, click **Storage**.
3.   In the Storage Devices list, click **Empty**.
4.   To the right of the Optical Drive menu, click the **Choose a virtual optical disk or a physical drive to use with the virtual drive** (blue disc) button.
5.   Click **Windows20H2.iso**.
6.   In the Storage Devices list, click **Windows20H2ProEFI64.vdi**.
7.   At the bottom of the Storage Devices list, click the **Removes selected storage attachment** (blue square with red X) button.
8.   Click **OK**.
9.   In the Oracle VM VirtualBox Manager window, click **Start**.
10.  Wait a few moments.  The virtual machine will display several messages, then will boot into the UEFI Interactive Shell v2.2.  Until noted, the following procedure applies to actions inside the virtual machine environment.
11.  At the Shell> prompt, type `exit` and press the **Enter** key.
12.  On the system screen that appears, press the **Down Arrow** key three times to select **Boot Maintenance Manager** and press the **Enter** key.
13.  The Boot Maintenance Manager will appear.  Press the **Enter** key to open the **Boot Options**.
14.  Press the **Down Arrow** key twice to select **Delete Boot Option** and press the **Enter** key.
15.  Press, in this order, **Space**, **Down Arrow**, **Down Arrow**, **Space** keys.  There should be **X** marks to the right of **Windows Boot Manager** and **UEFI VBOX HARDDISK** indicating that those two options are selected.
16.  Press the **Down Arrow** key twice to select **Commit Changes and Exit** and press the **Enter** key.
17.  Press the **Esc** key twice.
18.  Press the **Down Arrow** key to select **Continue** and press the **Enter** key.
19.  Wait a few moments.  The virtual machine will display several messages, then will boot into the UEFI Interactive Shell v2.2.
20.  Press the right **Ctrl** key on the keyboard to release the mouse from the virtual machine.  Until noted, the following procedure applies to actions inside the host environment.
21.  Click the **Close (X)** button in the upper-right corner of the Windows20H2ProEFI64 \[Running\] - Oracle VM VirtualBox window.
22.  In the Close Virtual Machine window that appears, click the radio button next to **Power off the machine** and click **OK**.
23.  In the Oracle VM VirtualBox Manager window, click **Settings**.
24.  In the Windows20H2ProEFI64 - Settings window, click **Storage** in the left column.
25.  At the bottom of the Storage Devices list, click the **Adds a new storage attachment** (blue square with green +) button, then click **Hard Disk**.
26.  In the Windows20H2ProEFI64 - Hard Disk Selector window, click **Windows20H2ProEFI64.vdi**, then click **Choose**.
27.  In the Windows20H2ProEFI64 - Settings window, click **OK**.
28.  This and the next two steps are time sensitive.  In the Oracle VM VirtualBox Manager windows, click **Start**.  Until noted, the following procedure applies to actions inside the virtual machine environment.
29.  When the Press any key to boot from CD or DVD message appears, press the **A** key.
30.  On the Windows Boot Manager Screen, ensure that **Windows 10 Setup (64-bit)** is selected.  Press **Enter**.
31.  Click the mouse in the center of the Windows20H2ProEFI64 window to allow the virtual machine to capture the mouse.
32.  In the Windows Setup window that appears, click **Next**.
33.  Click **Repair your computer**.
34.  Click **Troubleshoot**.
35.  Click **Command Prompt**.
36.  In the Command Prompt window that appears, type `diskpart` and press the **Enter** key.
37.  At the DISKPART> prompt, type `list disk` and press the **Enter** key.  Two disks should be listed.  Note which disk does not have a * character in the Gpt column (it is likely that Disk 1 does not have a * character in the Gpt column and the below instructions assume this; if the disk without the * character has a different disk number on your system, substitute that disk number in the instructions below).
38.  Type `select disk 1` (be sure to substitute the correct disk number in the command) and press the **Enter** key.
39.  Type `clean` and press the **Enter** key.
40.  Type `create partition primary` and press the **Enter** key.
41.  Type `format fs=ntfs quick label=Backup` and press the **Enter** key.
42.  Type `assign` and press the **Enter** key.
43.  Type `list volume` and press the **Enter** key.
44.  Note the drive letter of the Backup volume (likely drive E) and the drive letter of the Windows volume (likely drive C).  If the drive letters are not E and C, respectively, please substitute the drive letters for your system in the command below.
45.  Type `exit` and press the **Enter** key.
46.  Type `dism /capture-image /capturedir:c:\ /imagefile:e:\Windows20H2ProEFI64AuditMode.wim /name:Audit` (be sure to substitute the correct drive letters in the command) and press the **Enter** key.  The image capture process will begin and will take some time.
47.  When the image capture has completed, type `exit` and press the **Enter** key.
48.  On the Choose an option screen, click **Turn off your PC** and wait a moment as the virtual machine stops.
49.  Until noted, the following procedure applies to actions inside the host environment.

## Part 19 - Create A CopyProfile Answer File

1.   Right-click on the Start button and select **Disk Management**.
2.   In the Disk Management window, click the **Action** menu, then click **Attach VHD**.
3.   In the Attach Virtual Hard Disk window, click **Browse**.
4.   In the Browse Virtual Disk files window, open **This PC**, then **C:**, then **Users**, open your Windows account's folder, then open **VirtualBox VMs**, then **Windows20H2ProEFI64** and double-click **Windows20H2ProEFI64_1.vhd**.
5.   In the Attach Virtual Hard Disk window, click **OK**.
6.   In the bottom of the Disk Management window, note the drive letter of the Backup volume in the attached VHD.
7.   Click the **Start** button, scroll down in the programs list and click **Windows Kits**, then click **Windows System Image Manager**.
8.   In the Windows System Image Manager, click the **File** menu, click **Select Windows Image**.
9.   In the Select a Windows Image window, navigate to This PC, then open the Backup volume and double click on **Windows20H2ProEFIAuditMode.wim**.
10.  When asked Do you want to create a catalog file, click **Yes**.
11.  In the User Account Control dialog that appears, click **Yes**.
12.  The system may take a moment to create a catalog file.
13.  Once the catalog file is created, click the **File** menu, then click **New Answer File...**.
14.  In the Windows Image pane, expand **Components**, then right-click on **amd64_Microsoft-Windows-Shell-Setup_10.0.19041.1_neutral** and click **Add Setting to Pass 4 specialize**.
15.  In the Answer File pane, under **Components**, **4 specialize**, click **amd64-Microsoft-Windows-Shell-Setup_neutral**.
16.  In the Microsoft-Windows-Shell-Setup Properties pane, in the Settings section, click on **CopyProfile**, then select **true** from the pull down menu to the right of CopyProfile.
17.  Go to the **File** menu and click **Save Answer File As...**.
18.  In the Save As window that appears, navigate to This PC, then open the Backup volume, enter `Windows20H2ProEFI64CopyProfile.xml` in the File name field and click **Save**.
19.  Go to the **File** menu and click **Close Windows Image**.
20.  Go to the **File** menu and click **Exit**.
21.  When asked Do you want to save the changes to the answer file, click **No**.
22.  In the Disk Management window, right-click on the disk containing the Backup volume (the left-most column in the bottom pane) and click **Detach VHD**.
23.  In the Detach Virtual Hard Disk window, click **OK**.

## Part 20 - Export The Start Menu

1.   In the Oracle VM VirtualBox Manager window, click **Start**.
2.   Click inside the virtual machine window to allow the virtual machine to capture the keyboard and mouse.
3.   Until noted, the following procedure applies to actions inside the virtual machine environment.
4.   After the virtual machine starts and boots into Windows, click the **Cancel** button in the System Preparation Tool 3.14 window.
5.   Right-click on the **Start** button in the lower-left corner of the screen and click **Windows PowerShell (Admin)**.
6.   Type `export-startlayout -path $ENV:LOCALAPPDATA\Microsoft\Windows\Shell\LayoutModification.xml` and press the **Enter** key.
7.   Type `del (get-psreadlineoption).historysavepath` and press the **Enter** key.
8.   Close the PowerShell window by clicking the **Close (X)** button in the upper-right corner of the window.

## Part 21 - Run Sysprep

1.   Click the **File Explorer** (yellow folder) icon on the Taskbar.
2.   Note the drive letter for the Backup drive (likely E:).
3.   Close File Explorer by clicking on the **Close (X)** button in the upper-right corner of the window.
4.   Right-click on the **Start** button in the lower-left corner of the screen and click **Run**.
5.   In the Open field, type `c:\windows\system32\sysprep\sysprep.exe /generalize /oobe /shutdown /unattend:e:\Windows20H2ProEFI64CopyProfile.xml` (be sure to substitute the correct letter if e: is not the drive letter for the Backup drive noted in step 2) and press the **Enter** key.
6.   A message reading Sysprep is working... will appear.  Wait while the Sysprep program finishes running.
7.   When the Sysprep process completes, the virtual machine will automatically shut down.
8.   Until noted, the following procedure applies to actions inside the host environment.

## Part 22 - Capture An Image Of The Syspreped Virtual Machine

1.   In the Oracle VM VirtualBox Manager window, click **Settings**.
2.   In the Windows20H2ProEFI64 - Settings window, in the left column, click **Storage**.
3.   In the Storage Devices list, click **Windows20H2ProEFI64.vdi**.
4.   At the bottom of the Storage Devices list, click the **Removes selected storage attachment** (blue square with red X) button.
5.   Click **OK**.
6.   In the Oracle VM VirtualBox Manager window, click **Start**.
7.   Wait a few moments.  The virtual machine will display several messages, then will boot into the UEFI Interactive Shell v2.2.  Until noted, the following procedure applies to actions inside the virtual machine environment.
8.   At the Shell> prompt, type `exit` and press the **Enter** key.
9.   On the system screen that appears, press the **Down Arrow** key three times to select **Boot Maintenance Manager** and press the **Enter** key.
10.  The Boot Maintenance Manager will appear.  Press the **Enter** key to open the **Boot Options**.
11.  Press the **Down Arrow** key twice to select **Delete Boot Option** and press the **Enter** key.
12.  Press, in this order, **Space**, **Down Arrow**, **Down Arrow**, **Down Arrow**, **Space** keys.  There should be **X** marks to the right of **Windows Boot Manager** and **UEFI VBOX HARDDISK** indicating that those two options are selected.
13.  Press the **Down Arrow** key to select **Commit Changes and Exit** and press the **Enter** key.
14.  Press the **Esc** key twice.
15.  Press the **Down Arrow** key to select **Continue** and press the **Enter** key.
16.  Wait a few moments.  The virtual machine will display several messages, then will boot into the UEFI Interactive Shell v2.2.
17.  Press the right **Ctrl** key on the keyboard to release the mouse from the virtual machine.  Until noted, the following procedure applies to actions inside the host environment.
18.  Click the **Close (X)** button in the upper-right corner of the Windows20H2ProEFI64 \[Running\] - Oracle VM VirtualBox window.
19.  In the Close Virtual Machine window that appears, click the radio button next to **Power off the machine** and click **OK**.
20.  In the Oracle VM VirtualBox Manager window, click **Settings**.
21.  In the Windows20H2ProEFI64 - Settings window, click **Storage** in the left column.
22.  At the bottom of the Storage Devices list, click the **Adds a new storage attachment** (blue square with green +) button, then click **Hard Disk**.
23.  In the Windows20H2ProEFI64 - Hard Disk Selector window, click **Windows20H2ProEFI64.vdi**, then click **Choose**.
24.  In the Windows20H2ProEFI64 - Settings window, click **OK**.
25.  This and the next two steps are time sensitive.  In the Oracle VM VirtualBox Manager windows, click **Start**.  Until noted, the following procedure applies to actions inside the virtual machine environment.
26.  When the Press any key to boot from CD or DVD message appears, press the **A** key.
27.  On the Windows Boot Manager Screen, ensure that **Windows 10 Setup (64-bit)** is selected.  Press **Enter**.
28.  Click the mouse in the center of the Windows20H2ProEFI64 window to allow the virtual machine to capture the mouse.
29.  In the Windows Setup window that appears, click **Next**.
30.  Click **Repair your computer**.
31.  Click **Troubleshoot**.
32.  Click **Command Prompt**.
33.  In the Command Prompt window that appears, type `diskpart` and press the **Enter** key.
34.  At the DISKPART> prompt, type `list volume` and press the **Enter** key.
35.  Note the drive letter of the Backup volume (likely drive D) and the drive letter of the Windows volume (likely drive C).  If the drive letters are not D and C, respectively, please substitute the drive letters for your system in the command below.
36.  Type `exit` and press the **Enter** key.
37.  Type `dism /capture-image /capturedir:c:\ /imagefile:d:\Windows20H2ProEFI64SysprepWindows.wim /name:Windows` (be sure to substitute the correct drive letters in the command) and press the **Enter** key.  The image capture process will begin and will take some time.
38.  When the image capture has completed, type `dism /split-image /imagefile:d\Windows20H2ProEFI64SysprepWindows.wim /swmfile:d\Windows20H2ProEFI64SysprepWindows.swm /filesize:500` (be sure to substitute the correct drive letter in the command) and press the **Enter** key.
39.  When the image splitting process has completed, type `exit` and press the **Enter** key.
40.  On the Choose an option screen, click **Turn off your PC** and wait a moment as the virtual machine stops.
41.  Until noted, the following procedure applies to actions inside the host environment.
42.  In the Oracle VM VirtualBox Manager window, click the **File** menu, then click **Exit**.

## Part 23 - Copy Files From The Virtual Disk

1.   In the Disk Management window, click the **Action** menu, then click **Attach VHD**.
3.   In the Attach Virtual Hard Disk window, click **Browse**.
4.   In the Browse Virtual Disk files window, open **This PC**, then **C:**, then **Users**, open your Windows account's folder, then open **VirtualBox VMs**, then **Windows20H2ProEFI64** and double-click **Windows20H2ProEFI64_1.vhd**.
5.   In the Attach Virtual Hard Disk window, click **OK**.
6.   Right-click on the **Start** button in the lower-left corner of the screen and click **File Explorer**.
7.   Navigate to **This PC**, then open the **Backup** volume.
8.   Hold down the **Ctrl** key and click once on each of the SWM files (there should be 10 files total).  Release the **Ctrl** key.
9.   Right-click on one of the selected SWM files, then click **Copy**.
10.  Navigate to the **Documents** folder for your Windows user account, right-click in an empty area of the folder, then click **New**, then **Folder**.
11.  Name the folder `Images`.
12.  Open the **Images** folder.
13.  Right-click in an empty area of the folder, then click **Paste**.
14.  In the File Explorer window, click the **File** menu, then click **Close**.
15.  In the Disk Management window, right-click on the disk containing the Backup volume (the left-most column in the bottom pane) and click **Detach VHD**.
16.  In the Detach Virtual Hard Disk window, click **OK**.
17.  Click the **File** menu in the Disk Management window, then click **Exit**.

## Part 24 - Prepare The Windows PE Environment

1.   Click the **Start** button in the lower-left corner of the screen.
2.   Scroll downn in the Start menu's application list, then click on **Windows Kits**.
3.   Right-click on the **Deployment and Imaging Tools Environment**, click **More**, and click **Run as administrator**.
4.   In the User Account Control window, click **Yes**.
5.   In the Administrator: Deployment and Imaging Tools Environment window, enter `copype amd64 C:\amd64pe` and press the **Enter** key.
6.   Copy the text of the script below and paste it into the Administrator: Deployment and Imaging Tools Environment window to add PowerShell to the Windows PE environment.  Ensure that each command completes successfully.

    Dism /Mount-Image /ImageFile:"C:\amd64pe\media\sources\boot.wim" /Index:1 /MountDir:"C:\amd64pe\mount"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-NetFX.cab"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-NetFX_en-us.cab"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Scripting.cab"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-PowerShell.cab"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-StorageWMI.cab"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-StorageWMI_en-us.cab"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-DismCmdlets.cab"
    Dism /Add-Package /Image:"C:\amd64pe\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-DismCmdlets_en-us.cab"
    

7.   Type `notepad c:\amd64pe\mount\Windows\System32\startnet.cmd` and press the **Enter** key.
8.   Leave `wpeinit` on the first line, then add the second line `%SYSTEMDRIVE%\Windows\System32\WindowsPowerShell\v1.0\powershell.exe Set-ExecutionPolicy Unrestricted` then add a third line with `%SYSTEMDRIVE%\Windows\System32\WindowsPowerShell\v1.0\powershell.exe %SYSTEMDRIVE%\Windows\ImageComputer.ps1` and be sure that there is a Return after that line (so the cursor should be on the 4th line at the bottom of the file).  The entire file should now read as follows.

    wpeinit
    %SYSTEMDRIVE%\Windows\System32\WindowsPowerShell\v1.0\powershell.exe Set-ExecutionPolicy Unrestricted
    %SYSTEMDRIVE%\Windows\System32\WindowsPowerShell\v1.0\powershell.exe %SYSTEMDRIVE%\Windows\ImageComputer.ps1
    
    
9.   Click the **Close (X)** button in the upper-right corner of the window to close Notepad.  When prompted, click **Save**.
10.  In the Administrator: Deployment and Imaging Tools Environment window, type `notepad c:\amd64pe\mount\windows\ImageComputer.ps1` and press the **Enter** key.
11.  When prompted to create a new file, click **Yes**.
12.  Copy the full content of the ImageComputer.ps1 script from this repository (avaialble [here](https://raw.githubusercontent.com/pedonc/windows-deployment/master/Code/PowerShell/ImageComputer.ps1) and paste it into Notepad.  Ensure that there is a final empty line in the script after the last command to ensure that the last command executes.
13.  Click the **Close (X)** button in the upper-right corner of the window to close Notepad.  When prompted, click **Save**.
14.  To save the changes to the Windows PE image, type `dism /unmount-image /mountdir:c:\amd64pe\mount /commit` and press the **Enter** key.  It will take a moment for the system to save and unmount the image.

## Part 25 - Create The USB PE Media

1.   In the Administator: Deployment and Imaging Tools Environment, type `diskpart` and press the **Enter** key.
2.   Type `list disk` and press the **Enter** key.
3.   Note the disk numbers and capacities of the disks listed.
4.   Connect a USB flash drive that can be completely erased to the computer and wait a moment.  The ideal size for the flash drive is either 16GB or 32GB.
5.   Type `list disk` and press the **Enter** key.
6.   Compare the list of disks with the disk(s) listed in step 3 and determine the disk number of the USB flash drive.  It is critical to know the correct drive number before proceeding; do not proceed if you are unsure as you could erase important data.
7.   Type `select disk #` where # is the number of the USB flash drive determined in Step 6 and press the **Enter** key.
8.   Type `clean` and press the **Enter** key.
9.   Type `create partition primary` (if the USB flash drive is larger than 32GB, type `create partition primary size=32000`) and press the **Enter** key.
10.  Type `format fs=fat32 quick label=winpe` and press the **Enter** key.
11.  Type `active` and press the **Enter** key.
12.  Type `assign` and press the **Enter** key.
13.  Type `exit` and press the **Enter** key.
14.  Open **File Explorer** and go to **This PC**.
15.  Note the drive letter of the WINPE USB drive.
16.  Return to the Administrator: Deployment and Imaging Tools Environment window.
17.  Type `xcopy c:\amd64pe\media\*.* /s /e /f u:` where u is the drive letter of the WINPE USB drive noted in Step 15.
18.  Return to **File Explorer**.  Open the **Documents** folder for your Windows user account and right-click on **Images**.  Click **Copy**.
19.  Open the **WINPE** USB drive in File Explorer, right-click in an empty area of the drive, and click **Paste**.  Wait until the copy process completes.
20.  The USB drive should now be bootable and will automate much of the Windows installation and configuration process.  Importantly, do not connect the USB drive to any computer that cannot be fully erased and please ensure that no additional USB disks or peripherals are connected to any computer when the USB drive is used (to avoid accidentally erasing other media).  It should be possible to repeat the steps in Part 33 with other USB drives to make multiple copies of the automated USB installer.  Good luck!

## License

All content copyright (c) 2021 Curtis Glavin, Jonathan Huppi, Joshua Casiano

All code in this repository is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3 as published by the Free Software Foundation.

All code in this repository is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

A copy of the GNU General Public License version 3 is available [in this repository](https://raw.githubusercontent.com/pedonc/windows-deployment/master/LICENSE) and from the Free Software Foundation at [https://www.gnu.org/licenses/gpl-3.0.txt](https://www.gnu.org/licenses/gpl-3.0.txt).

All documentation in this repository is licensed under the GNU Free Documentation License version 1.3.

Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.3 or any later version published by the Free Software Foundation; with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.  A copy of the license is included in the section entitled "GNU Free Documentation License".  Additionally, a copy of the license is available [in this repository](https://raw.githubusercontent.com/pedonc/windows-deployment/master/fdl.txt) and from the Free Software Foundation at [https://www.gnu.org/licenses/fdl.txt](https://www.gnu.org/licenses/fdl.txt).

## GNU Free Documentation License

Version 1.3, 3 November 2008

Copyright Â© 2000, 2001, 2002, 2007, 2008 Free Software Foundation, Inc. <https://fsf.org/>

Everyone is permitted to copy and distribute verbatim copies of this license document, but changing it is not allowed.

0\. PREAMBLE

The purpose of this License is to make a manual, textbook, or other functional and useful document "free" in the sense of freedom: to assure everyone the effective freedom to copy and redistribute it, with or without modifying it, either commercially or noncommercially. Secondarily, this License preserves for the author and publisher a way to get credit for their work, while not being considered responsible for modifications made by others.

This License is a kind of "copyleft", which means that derivative works of the document must themselves be free in the same sense. It complements the GNU General Public License, which is a copyleft license designed for free software.

We have designed this License in order to use it for manuals for free software, because free software needs free documentation: a free program should come with manuals providing the same freedoms that the software does. But this License is not limited to software manuals; it can be used for any textual work, regardless of subject matter or whether it is published as a printed book. We recommend this License principally for works whose purpose is instruction or reference.

1\. APPLICABILITY AND DEFINITIONS

This License applies to any manual or other work, in any medium, that contains a notice placed by the copyright holder saying it can be distributed under the terms of this License. Such a notice grants a world-wide, royalty-free license, unlimited in duration, to use that work under the conditions stated herein. The "Document", below, refers to any such manual or work. Any member of the public is a licensee, and is addressed as "you". You accept the license if you copy, modify or distribute the work in a way requiring permission under copyright law.

A "Modified Version" of the Document means any work containing the Document or a portion of it, either copied verbatim, or with modifications and/or translated into another language.

A "Secondary Section" is a named appendix or a front-matter section of the Document that deals exclusively with the relationship of the publishers or authors of the Document to the Document's overall subject (or to related matters) and contains nothing that could fall directly within that overall subject. (Thus, if the Document is in part a textbook of mathematics, a Secondary Section may not explain any mathematics.) The relationship could be a matter of historical connection with the subject or with related matters, or of legal, commercial, philosophical, ethical or political position regarding them.

The "Invariant Sections" are certain Secondary Sections whose titles are designated, as being those of Invariant Sections, in the notice that says that the Document is released under this License. If a section does not fit the above definition of Secondary then it is not allowed to be designated as Invariant. The Document may contain zero Invariant Sections. If the Document does not identify any Invariant Sections then there are none.

The "Cover Texts" are certain short passages of text that are listed, as Front-Cover Texts or Back-Cover Texts, in the notice that says that the Document is released under this License. A Front-Cover Text may be at most 5 words, and a Back-Cover Text may be at most 25 words.

A "Transparent" copy of the Document means a machine-readable copy, represented in a format whose specification is available to the general public, that is suitable for revising the document straightforwardly with generic text editors or (for images composed of pixels) generic paint programs or (for drawings) some widely available drawing editor, and that is suitable for input to text formatters or for automatic translation to a variety of formats suitable for input to text formatters. A copy made in an otherwise Transparent file format whose markup, or absence of markup, has been arranged to thwart or discourage subsequent modification by readers is not Transparent. An image format is not Transparent if used for any substantial amount of text. A copy that is not "Transparent" is called "Opaque".

Examples of suitable formats for Transparent copies include plain ASCII without markup, Texinfo input format, LaTeX input format, SGML or XML using a publicly available DTD, and standard-conforming simple HTML, PostScript or PDF designed for human modification. Examples of transparent image formats include PNG, XCF and JPG. Opaque formats include proprietary formats that can be read and edited only by proprietary word processors, SGML or XML for which the DTD and/or processing tools are not generally available, and the machine-generated HTML, PostScript or PDF produced by some word processors for output purposes only.

The "Title Page" means, for a printed book, the title page itself, plus such following pages as are needed to hold, legibly, the material this License requires to appear in the title page. For works in formats which do not have any title page as such, "Title Page" means the text near the most prominent appearance of the work's title, preceding the beginning of the body of the text.

The "publisher" means any person or entity that distributes copies of the Document to the public.

A section "Entitled XYZ" means a named subunit of the Document whose title either is precisely XYZ or contains XYZ in parentheses following text that translates XYZ in another language. (Here XYZ stands for a specific section name mentioned below, such as "Acknowledgements", "Dedications", "Endorsements", or "History".) To "Preserve the Title" of such a section when you modify the Document means that it remains a section "Entitled XYZ" according to this definition.

The Document may include Warranty Disclaimers next to the notice which states that this License applies to the Document. These Warranty Disclaimers are considered to be included by reference in this License, but only as regards disclaiming warranties: any other implication that these Warranty Disclaimers may have is void and has no effect on the meaning of this License.

2\. VERBATIM COPYING

You may copy and distribute the Document in any medium, either commercially or noncommercially, provided that this License, the copyright notices, and the license notice saying this License applies to the Document are reproduced in all copies, and that you add no other conditions whatsoever to those of this License. You may not use technical measures to obstruct or control the reading or further copying of the copies you make or distribute. However, you may accept compensation in exchange for copies. If you distribute a large enough number of copies you must also follow the conditions in section 3.

You may also lend copies, under the same conditions stated above, and you may publicly display copies.

3\. COPYING IN QUANTITY

If you publish printed copies (or copies in media that commonly have printed covers) of the Document, numbering more than 100, and the Document's license notice requires Cover Texts, you must enclose the copies in covers that carry, clearly and legibly, all these Cover Texts: Front-Cover Texts on the front cover, and Back-Cover Texts on the back cover. Both covers must also clearly and legibly identify you as the publisher of these copies. The front cover must present the full title with all words of the title equally prominent and visible. You may add other material on the covers in addition. Copying with changes limited to the covers, as long as they preserve the title of the Document and satisfy these conditions, can be treated as verbatim copying in other respects.

If the required texts for either cover are too voluminous to fit legibly, you should put the first ones listed (as many as fit reasonably) on the actual cover, and continue the rest onto adjacent pages.

If you publish or distribute Opaque copies of the Document numbering more than 100, you must either include a machine-readable Transparent copy along with each Opaque copy, or state in or with each Opaque copy a computer-network location from which the general network-using public has access to download using public-standard network protocols a complete Transparent copy of the Document, free of added material. If you use the latter option, you must take reasonably prudent steps, when you begin distribution of Opaque copies in quantity, to ensure that this Transparent copy will remain thus accessible at the stated location until at least one year after the last time you distribute an Opaque copy (directly or through your agents or retailers) of that edition to the public.

It is requested, but not required, that you contact the authors of the Document well before redistributing any large number of copies, to give them a chance to provide you with an updated version of the Document.

4\. MODIFICATIONS

You may copy and distribute a Modified Version of the Document under the conditions of sections 2 and 3 above, provided that you release the Modified Version under precisely this License, with the Modified Version filling the role of the Document, thus licensing distribution and modification of the Modified Version to whoever possesses a copy of it. In addition, you must do these things in the Modified Version:

A. Use in the Title Page (and on the covers, if any) a title distinct from that of the Document, and from those of previous versions (which should, if there were any, be listed in the History section of the Document). You may use the same title as a previous version if the original publisher of that version gives permission.

B. List on the Title Page, as authors, one or more persons or entities responsible for authorship of the modifications in the Modified Version, together with at least five of the principal authors of the Document (all of its principal authors, if it has fewer than five), unless they release you from this requirement.

C. State on the Title page the name of the publisher of the Modified Version, as the publisher.

D. Preserve all the copyright notices of the Document.

E. Add an appropriate copyright notice for your modifications adjacent to the other copyright notices.

F. Include, immediately after the copyright notices, a license notice giving the public permission to use the Modified Version under the terms of this License, in the form shown in the Addendum below.

G. Preserve in that license notice the full lists of Invariant Sections and required Cover Texts given in the Document's license notice.

H. Include an unaltered copy of this License.

I. Preserve the section Entitled "History", Preserve its Title, and add to it an item stating at least the title, year, new authors, and publisher of the Modified Version as given on the Title Page. If there is no section Entitled "History" in the Document, create one stating the title, year, authors, and publisher of the Document as given on its Title Page, then add an item describing the Modified Version as stated in the previous sentence.

J. Preserve the network location, if any, given in the Document for public access to a Transparent copy of the Document, and likewise the network locations given in the Document for previous versions it was based on. These may be placed in the "History" section. You may omit a network location for a work that was published at least four years before the Document itself, or if the original publisher of the version it refers to gives permission.

K. For any section Entitled "Acknowledgements" or "Dedications", Preserve the Title of the section, and preserve in the section all the substance and tone of each of the contributor acknowledgements and/or dedications given therein.

L. Preserve all the Invariant Sections of the Document, unaltered in their text and in their titles. Section numbers or the equivalent are not considered part of the section titles.

M. Delete any section Entitled "Endorsements". Such a section may not be included in the Modified Version.

N. Do not retitle any existing section to be Entitled "Endorsements" or to conflict in title with any Invariant Section.

O. Preserve any Warranty Disclaimers.
If the Modified Version includes new front-matter sections or appendices that qualify as Secondary Sections and contain no material copied from the Document, you may at your option designate some or all of these sections as invariant. To do this, add their titles to the list of Invariant Sections in the Modified Version's license notice. These titles must be distinct from any other section titles.

You may add a section Entitled "Endorsements", provided it contains nothing but endorsements of your Modified Version by various partiesâ€”for example, statements of peer review or that the text has been approved by an organization as the authoritative definition of a standard.

You may add a passage of up to five words as a Front-Cover Text, and a passage of up to 25 words as a Back-Cover Text, to the end of the list of Cover Texts in the Modified Version. Only one passage of Front-Cover Text and one of Back-Cover Text may be added by (or through arrangements made by) any one entity. If the Document already includes a cover text for the same cover, previously added by you or by arrangement made by the same entity you are acting on behalf of, you may not add another; but you may replace the old one, on explicit permission from the previous publisher that added the old one.

The author(s) and publisher(s) of the Document do not by this License give permission to use their names for publicity for or to assert or imply endorsement of any Modified Version.

5\. COMBINING DOCUMENTS

You may combine the Document with other documents released under this License, under the terms defined in section 4 above for modified versions, provided that you include in the combination all of the Invariant Sections of all of the original documents, unmodified, and list them all as Invariant Sections of your combined work in its license notice, and that you preserve all their Warranty Disclaimers.

The combined work need only contain one copy of this License, and multiple identical Invariant Sections may be replaced with a single copy. If there are multiple Invariant Sections with the same name but different contents, make the title of each such section unique by adding at the end of it, in parentheses, the name of the original author or publisher of that section if known, or else a unique number. Make the same adjustment to the section titles in the list of Invariant Sections in the license notice of the combined work.

In the combination, you must combine any sections Entitled "History" in the various original documents, forming one section Entitled "History"; likewise combine any sections Entitled "Acknowledgements", and any sections Entitled "Dedications". You must delete all sections Entitled "Endorsements".

6\. COLLECTIONS OF DOCUMENTS

You may make a collection consisting of the Document and other documents released under this License, and replace the individual copies of this License in the various documents with a single copy that is included in the collection, provided that you follow the rules of this License for verbatim copying of each of the documents in all other respects.

You may extract a single document from such a collection, and distribute it individually under this License, provided you insert a copy of this License into the extracted document, and follow this License in all other respects regarding verbatim copying of that document.

7\. AGGREGATION WITH INDEPENDENT WORKS

A compilation of the Document or its derivatives with other separate and independent documents or works, in or on a volume of a storage or distribution medium, is called an "aggregate" if the copyright resulting from the compilation is not used to limit the legal rights of the compilation's users beyond what the individual works permit. When the Document is included in an aggregate, this License does not apply to the other works in the aggregate which are not themselves derivative works of the Document.

If the Cover Text requirement of section 3 is applicable to these copies of the Document, then if the Document is less than one half of the entire aggregate, the Document's Cover Texts may be placed on covers that bracket the Document within the aggregate, or the electronic equivalent of covers if the Document is in electronic form. Otherwise they must appear on printed covers that bracket the whole aggregate.

8\. TRANSLATION

Translation is considered a kind of modification, so you may distribute translations of the Document under the terms of section 4. Replacing Invariant Sections with translations requires special permission from their copyright holders, but you may include translations of some or all Invariant Sections in addition to the original versions of these Invariant Sections. You may include a translation of this License, and all the license notices in the Document, and any Warranty Disclaimers, provided that you also include the original English version of this License and the original versions of those notices and disclaimers. In case of a disagreement between the translation and the original version of this License or a notice or disclaimer, the original version will prevail.

If a section in the Document is Entitled "Acknowledgements", "Dedications", or "History", the requirement (section 4) to Preserve its Title (section 1) will typically require changing the actual title.

9\. TERMINATION

You may not copy, modify, sublicense, or distribute the Document except as expressly provided under this License. Any attempt otherwise to copy, modify, sublicense, or distribute it is void, and will automatically terminate your rights under this License.

However, if you cease all violation of this License, then your license from a particular copyright holder is reinstated (a) provisionally, unless and until the copyright holder explicitly and finally terminates your license, and (b) permanently, if the copyright holder fails to notify you of the violation by some reasonable means prior to 60 days after the cessation.

Moreover, your license from a particular copyright holder is reinstated permanently if the copyright holder notifies you of the violation by some reasonable means, this is the first time you have received notice of violation of this License (for any work) from that copyright holder, and you cure the violation prior to 30 days after your receipt of the notice.

Termination of your rights under this section does not terminate the licenses of parties who have received copies or rights from you under this License. If your rights have been terminated and not permanently reinstated, receipt of a copy of some or all of the same material does not give you any rights to use it.

10\. FUTURE REVISIONS OF THIS LICENSE

The Free Software Foundation may publish new, revised versions of the GNU Free Documentation License from time to time. Such new versions will be similar in spirit to the present version, but may differ in detail to address new problems or concerns. See [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).

Each version of the License is given a distinguishing version number. If the Document specifies that a particular numbered version of this License "or any later version" applies to it, you have the option of following the terms and conditions either of that specified version or of any later version that has been published (not as a draft) by the Free Software Foundation. If the Document does not specify a version number of this License, you may choose any version ever published (not as a draft) by the Free Software Foundation. If the Document specifies that a proxy can decide which future versions of this License can be used, that proxy's public statement of acceptance of a version permanently authorizes you to choose that version for the Document.

11\. RELICENSING

"Massive Multiauthor Collaboration Site" (or "MMC Site") means any World Wide Web server that publishes copyrightable works and also provides prominent facilities for anybody to edit those works. A public wiki that anybody can edit is an example of such a server. A "Massive Multiauthor Collaboration" (or "MMC") contained in the site means any set of copyrightable works thus published on the MMC site.

"CC-BY-SA" means the Creative Commons Attribution-Share Alike 3.0 license published by Creative Commons Corporation, a not-for-profit corporation with a principal place of business in San Francisco, California, as well as future copyleft versions of that license published by that same organization.

"Incorporate" means to publish or republish a Document, in whole or in part, as part of another Document.

An MMC is "eligible for relicensing" if it is licensed under this License, and if all works that were first published under this License somewhere other than this MMC, and subsequently incorporated in whole or in part into the MMC, (1) had no cover texts or invariant sections, and (2) were thus incorporated prior to November 1, 2008.

The operator of an MMC Site may republish an MMC contained in the site under CC-BY-SA on the same site at any time before August 1, 2009, provided the MMC is eligible for relicensing.

ADDENDUM: How to use this License for your documents

To use this License in a document you have written, include a copy of the License in the document and put the following copyright and license notices just after the title page:

Copyright (C)  YEAR  YOUR NAME.
Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.3 or any later version published by the Free Software Foundation; with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.
A copy of the license is included in the section entitled "GNU Free Documentation License".

If you have Invariant Sections, Front-Cover Texts and Back-Cover Texts, replace the "with â€¦ Texts." line with this:

with the Invariant Sections being LIST THEIR TITLES, with the Front-Cover Texts being LIST, and with the Back-Cover Texts being LIST.
If you have Invariant Sections without Cover Texts, or some other combination of the three, merge those two alternatives to suit the situation.

If your document contains nontrivial examples of program code, we recommend releasing these examples in parallel under your choice of free software license, such as the GNU General Public License, to permit their use in free software.
