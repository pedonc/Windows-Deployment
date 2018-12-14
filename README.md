# Tools And Documentation To Automate And Manage Windows Deployment

These instructions are for creating a customized Windows 10 environment that can be easily installed onto PCs through an automated, bootable USB installer.  The instructions are precise and detailed so anyone with general experience using Windows should be able to follow this process, while experienced system administrators can customize settings as desired.  Finally, while the process to create the USB installer takes many steps, the end result will be a tool that can be used to configure a Windows PC in minutes instead of hours.

## Recommended Minimum PC Requirements

* 64-bit UEFI
* Windows Professional 1809 64-bit
* 8GB of RAM
* 60GB of free disk space
* Empty USB flash drive with 16-32GB capacity

Before beginning, it is critical to ensure that your computer's time zone and date and time settings are correct.  Please note that having a computer with a fast processor, solid state disk, and lots of RAM will make this process faster.  Additionally, USB flash drives with more than 32GB of capacity cannot easily be formatted to be bootable with Windows.  A fast USB 3.0 32GB flash drive is highly recommended.

## Part 1 - Download Windows 10

1.  On a Windows 10 Professional computer running Windows version 1809 64-bit, go to Microsoft's Download Windows 10 page (currently available at <https://www.microsoft.com/en-us/software-download/windows10>).
2.  Download the Create Windows 10 installation media tool (currently MediaCreationTool1809.exe available from <https://go.microsoft.com/fwlink/?LinkId=691209>).
3.  Run the downloaded tool.  In the User Account Control window that appears, click **Yes** when asked Do you want to allow this app to make changes to your device?
4.  In the Windows 10 Setup window that appears, click **Accept**.
5.  On the What do you want to do? screen, select **Create installation media (USB flash drive, DVD, or ISO file) for another PC**.
6.  Click the **Next** button.
7.  On the Select language, architecture, and edition screen, uncheck **Use the recommended options for this PC**.
8.  Set the Language field to **English (United States)**, set the Edition field to **Windows 10**, set the Architecture to **Both**.
9.  Click the **Next** button.
10. On the Choose which media to use screen, select **ISO file**.
11. Click the **Next** button.
12. In the Select a path window that appears, open the **Documents** folder for your Windows user account, and enter `Windows1809.iso` in the File name field, then click **Save**.
13. The computer will download the ISO file (this may take several minutes).
14. When the download is complete, click the **Finish** button.

## Part 2 - Download Windows ADK

1.  Go to Microsoft's Download and install the Windows ADK page (currently available at <https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install>).
2.  Download the Windows ADK for Windows 10, version 1809 (currently available from <https://go.microsoft.com/fwlink/?linkid=2026036>).
3.  Download the Windows PE add-on for the ADK (currently available from <https://go.microsoft.com/fwlink/?linkid=2022233>).
4.  Run the adksetup.exe tool.  In the installation window that appears, click **Next**.
5.  Click **No** then click **Next**.
6.  Click **Accept**.
7.  Check all the installable features and click **Install**.
8.  Click **Yes** when prompted to allow installation.
9.  When the installation process is complete, click **Close**.
10. Run the **adkwinpesetup.exe** tool.  In the installation window that appears, ensure that Install the Windows Assessment and Deployment Kit Windows Preinstallation Enviromnet Add-ons - Windows 10 to this computer is selected and click the **Next** button.
11. Click **No** then click **Next**.
12. Click **Accept**.
13. Check all the installable features and click **Install**.
14. In the User Account Control window, click **Yes**.
15. When the installation is complete, click the **Close** button.

## Part 3 - Install VirtualBox

1.  Go to <https://www.virtualbox.org>.
2.  Click the [**Downloads**](https://www.virtualbox.org/wiki/Downloads) link in the navigation menu.
3.  Click the link to download VirtualBox for [**Windows hosts**](https://download.virtualbox.org/virtualbox/5.2.22/VirtualBox-5.2.22-126460-Win.exe) and save the download on your computer (at the time of publication, the latest version of VirtualBox is 5.2.22).
4.  Click the link to download the Oracle VM VirtualBox Extension Pack for [All supported platforms](https://download.virtualbox.org/virtualbox/5.2.22/Oracle_VM_VirtualBox_Extension_Pack-5.2.22.vbox-extpack) and save the download on your computer.
5.  Run the **VirtualBox-5.2.22-126460-Win.exe** installer on your computer.
6.  In the Oracle VM VirtualBox 5.2.22 Setup window that appears, on the Welcome to the Oracle VM VirtualBox 5.2.22 Setup Wizard screen, click **Next**.
7.  On the first Custom Setup screen, click **Next**.
8.  On the second Custom Setup screen, configure the options as preferred (suggested settings: Create start menu entries and Register file associations are checked, Create a shortcut on the desktop and Create a shortcut in the Quick Launch Bar are unchecked) and click **Next**.
9.  On the Warning: Network Interfaces screen, click **Yes**.
10. On the Ready to Install screen, click **Install**.
11. In the User Account Control window that appears, click **Yes** when asked Do you want to allow this app to make changes to your device?
12. In the Windows Security window that appears, when asked Would you like to install this device software? ensure that Always trust software from "Oracle Corporation" is checked and click **Install**.
13. On the Oracle VM VirtualBox 5.2.18 installation is complete screen, ensure that Start Oracle VM VirtualBox 5.2.22 after installation is checked, then click **Finish**.
14. In the Oracle VM VirtualBox Manager application that appears, open the **File** menu and click **Preferences...**
15. In the VirtualBox - Preferences window, click on **Update** in the left column, uncheck **Check for Updates** and click **OK**.

## Part 4 - Configure EFI 64 Bit Virtual Machine

1.  In the Oracle VM VirtualBox Manager application, click the **New** button.
2.  If the window that appears features an Expert Mode button, click the **Expert Mode** button.
3.  In the Create Virtual Machine window that appears, in the Name field, enter `WindowsEFI64`.
4.  Select **Microsoft Windows** for Type, **Windows 10 (64-bit)** for Version, set Memory size to `4096` or larger if your computer host computer has more than 8GB RAM, and select **Create a virtual hard disk now**.
5.  Click the **Create** button.
6.  In the Create Virtual Hard Disk window, in the Hard disk file type section, select **VMDK (Virtual Machine Disk)**.
7.  In the Storage on physical hard disk section, select **Dynamically allocated** and select **Split into files of less than 2GB**.
8.  In the File size section, set the disk size to `50.00` GB.
9.  Click the folder icon in the File location section, in the Please choose a location for new virtual hard disk file window, open the Documents folder for your Windows user account, create a folder named Virtual Machines.
10. Open the Virtual Machines folder, create a folder inside named WindowsEFI64.
11. Open the WindowsEFI64 folder, then click **Save** to save the virtual hard disk file as WindowsEFI64.vdmk in that folder.
12. Click the **Create** button.
13. In the Oracle VM VirtualBox Manager window, select the WindowsEFI64 virtual machine in the left column, then click the **Settings** button.
14. In the WindowsEFI64 - Settings window, click on **System** in the left column.
15. On the Motherboard tab of System, uncheck **Floppy** from Boot Order, set Pointing Device to **PS/2 Mouse**, and check **Enable EFI (special OSes only)**.
16. In the WindowsEFI64 - Settings window, click on **Storage** in the left column.
17. In the Storage Devices pane, click on the **Empty** optical drive.
18. In the Attributes area on the right side of the window, click on the disc icon on the right of the Optical Drive pull down menu, then click **Choose Virtual Optical Disc File...**.
19. In the file browser that appears, select the **Windows1809.iso** file you downloaded and click **Open**.
20. In the WindowsEFI64 - Settings window, click on **Audio** in the left column.
21. Uncheck **Enable Audio**.
22. In the WindowsEFI64 - Settings window, click on **Network** in the left column.
23. Uncheck **Enable Network Adapter**.
24. In the WindowsEFI64 - Settings window, click on **USB** in the left column.
25. Uncheck **Enable USB Controller**.
26. Click the **OK** button in the lower-right corner to complete configuration of the virtual machine.

## Part 5 - Boot The Windows Installer In The Virtual Machine

1.  In the Oracle VM VirtualBox Manager window, select the **WindowsEFI64** virtual machine in the left column, then click the **Start** button to start the virtual machine.
2.  Wait a few moments.  The virtual machine will display several messages, then will boot into the UEFI Interactive Shell v2.1.
3.  Click in the WindowsEFI64 \[Running] virtual machine screen that appears and note the VirtualBox - Information dialog that appears.  Read the note and check the **Do not show this message again** box, then click the **Capture** button.
4.  At the top of the WindowsEFI64 \[Running] virtual machine screen, there will be a notification that "You have the Auto capture keyboard option turned on."  Click the **Do not show this message again** icon (the right-most text bubble strike through icon on the message) to disable this notification.
5.  At the Shell> prompt, type `exit` and press the **Enter** key.
6.  On the system screen that appears, press the **Down Arrow** key twice to select **Boot Manager** and press the **Enter** key.
7.  The Boot Option Menu should appear with **EFI DVD/CDROM** selected.  Press **Enter**.
8.  A message reading Press any key to boot from CD or DVD should appear.  Immediately press **Enter**.
9.  The Windows Boot Manager screen should appear.  **Windows 10 Setup (64-bit)** should be selected.  Press **Enter**.
10. At the top of the WindowsEFI64 virtual machine screen, a message should appear indicating that "The Virtual Machine reports that the guest OS does not support mouse pointer integration in the current video mode."  Press the right **Control** key on the keyboard, then click the **Do not show this message again** icon (the right-most text bubble strike through icon on the message) to disable this notification.  Click the mouse inside the virtual machine window to return the mouse to the virtual machine.
11. Until noted, the following procedure applies to actions inside the virtual machine environment.

## Part 6 - Install Windows In The Virtual Machine

1.  On the first Windows Setup screen, click the **Next** button.
2.  Click **Install now**.
3.  On the Activate Windows screen, click the **I don't have a product key** link.
4.  On the Select the operating system you want to install screen, select **Windows 10 Pro** and click the **Next** button.
5.  On the Applicable notices and license terms screen, check **I accept the license terms** and click **Next**.
6.  On the Which type of installation do you want screen, click **Custom: Install Windows only (advanced)**.
7.  Ensure that **Drive 0 Unallocated Space** is selected, then click **Next**.
8.  The Windows installation will begin.  Please wait while files are copied to the virtual machine's disk.  The virtual machine will automatically restart.
9.  Eventually, the Let's start with region screen will appear.

## Part 7 - Enable Windows Audit Mode

1.  To bypass the Windows configuration wizard and enter Audit Mode, press and hold the **Control** and **Shift** keys at the same time, then press the **F3** key (for a moment, all three keys should be pressed at the same time).  Release all the keyboard keys.
2.  The virtual machine will restart and will log the built-in Administrator account into Windows in Audit Mode.
3.  When Audit Mode starts, the system will automatically launch the System Preparation Tool 3.14 graphical interface.  Click **Cancel** to close the tool.
4.  Importantly, please note that Parts 8-15 must be completed without shutting down or restarting the virtual machine, as Windows will only allow customization of certain settings on the first boot.

## Part 8 - Disable Sounds

1.  Right-click on the **Windows Start Menu** icon in the lower-left corner of the screen and click **Run**.
2.  In the Open field, type `control panel` and press the **Enter** key.
3.  In the upper-right corner of the Control Panel window that appears, click on the **View by** pull down menu and click **Large icons** to switch from the Category option to Large icons.
4.  Click **Sound**.
5.  In the Sound window, go to the **Sounds** tab.
6.  Change Sound Scheme to **No Sounds**, then click the **OK** button.
7.  Click the **Close (X)** button in the upper-right corner of the All Control Panel Items window to close the window.

## Part 9 - Configure Settings

1.  Click on the **Windows Start Menu** icon in the lower-left corner of the screen, then **Settings** (gear icon).
2.  Go to **Personalization**.
3.  Go to **Colors**.
4.  Scroll down and set **Choose your default app mode** to **Dark**.
5.  Turn **Transparency effects** **Off**.
6.  Go to **Background**.
7.  Set **Background** to **Solid color**.
8.  Go to **Lock screen**.
9.  Set **Background** to **Picture**.
10. Set **Get fun facts, tips, and more from Windows and Cortana on your lock screen** to **Off**.
11. Go to **Themes**.
12. Click **Save theme**.
13. In the Save your theme popup that appears, in the Name your theme field, enter `Default` and click the **Save** button.
14. Go to **Start**.
15. Turn **Show recently added apps** **Off**.
16. Turn **Show suggestions occasionally in Start** **Off**.
17. Turn **Show recently opened items in Jump Lists on Start or the taskbar** **Off**.
18. Go to **Taskbar**.
19. Turn **Show badges on taskbar buttons** **Off**.
20. Click **Select which icons appear on the taskbar**.
21. Turn **Always show all icons in the notification area** **On**.
22. In the upper-left corner of the window, click the **Back** arrow button.
23. Go to **Turn system icons on or off**.
24. Set **Action Center**, **Location**, **Input indicator**, **Network** to **Off**.
25. In the upper-left corner of the window, click the **Back** arrow button.
26. Scroll down to the bottom of the window.
27. Turn **Show My People app suggestions** **Off**.
28. Turn **Play a sound when a My People notification arrives** **Off**.
29. Turn **Show My People notifications** **Off**.
30. Turn **Show contacts on the taskbar** **Off**.
31. In the upper-left corner of the window, click the **Home** button.
32. Click **System**.
33. Click **Notifications & actions**.
34. Click **Add or remove quick actions**.
35. Set **Tablet Mode**, **Location**, **VPN**, **Project**, and **Connect** to **Off**.
36. In the upper-left corner of the window, click the **Back** arrow button.
37. Turn **Show notifications on the lock screen** **Off**.
38. Turn **Show reminders and incoming VoIP calls on the lock screen** **Off**.
39. Turn **Show me the Windows welcome experience after updates and occasionally when I sign in to highlight what's new and suggested** **Off**.
40. Turn **Get tips, tricks, and suggestions as you use Windows** **Off**.
41. Turn **Get notifications from apps and other senders** **Off**.
42. Click **Focus assist**.
43. Turn **When I'm playing a game** **Off**.
44. Turn **When I'm duplicating my display** **Off**.
45. Click **Tablet mode**.
46. Turn **Hide app icons on the taskbar in tablet mode** **Off**.
47. Set **When this device automatically switches tablet mode on or off** to **Don't ask me and don't switch**.
48. Set **When I sign in** to **Use desktop mode**.
49. Click **Multitasking**.
50. Set **Show suggestions occasionally in your timeline** to **Off**.
51. Click **Shared experiences**.
52. Turn **Let apps on other devices (including linked phones and tablets) open and message apps on this device, and vice versa** **Off**.
53. In the upper-left corner of the window, click **Home**.
54. Click **Devices**.
55. Click on **Printers & scanners**.
56. Uncheck **Let Windows manage my default printer**.
57. Click **Pen & Windows Ink**.
58. Uncheck **Show recommended app suggestions**.
59. Click **AutoPlay**.
60. Turn **Use AutoPlay for all media and devices** **Off**.
61. Click **Home**.
62. Click **Apps**.
63. Set **Installing apps** to **Turn off app recommendations**.
64. Click on and **Uninstall** the following apps in the list: **App Installer**, **Feedback Hub**, **Microsoft OneDrive**, **Microsoft Solitaire Collection**, **Mixed Reality Portal**, **Mobile Plans**, **My Office**, **OneNote**, **Print 3D**, **Skype**, **Tips**, **Weather**, **Web Media Extensions**, **Xbox Live**.
65. Click **Offline Maps**.
66. Click **Delete all maps** and click **Delete all** in the popup that appears.
67. Set **Automatically update maps** to **Off**.
68. Click on **Apps for websites**.
69. Set **Microsoft Edge** and **Maps** (there may be two Maps listed, set them both) to **Off**.
70. Click **Startup**.
71. Set **Windows Security notification icon** to **Off**.
72. Click **Home**.
73. Click **Gaming**.
74. Turn **Record game clips, screenshots, and broadcast using Game bar** **Off.**
75. Uncheck **Open Game bar using this button on a controller**.
76. Click **Game Mode**.
77. Turn **Game Mode** **Off**.
78. Click **Home**.
79. Click **Cortana**.
80. Set **Use Cortana even when my device is locked** **Off**.
81. Click **Permissions & History**.
82. Click **Clear my device history**.
83. Set **My device history**, **Activity recommendations**, and **Windows Cloud Search** to **Off**.
84. Click **Home**.
85. Click **Privacy**.
86. Set **Let websites provide locally relevant content by accessing my language list**, **Let Windows track app launches to improve Start and search results**, **Show me suggested content in the Settings app** to **Off**.
87. Click **Inking & typing personalization**.
88. Set **Getting to know you** **Off**.
89. Click **Diagnostics & feedback**.
90. Set **Improve inking and typing** **Off**.
91. Click **Delete** to delete the diagnostic data from the system.
92. Set **Windows should ask for my feedback** to **Never**.
93. At the top of the screen, set **Diagnostic data** to **Basic**.
94. Click **Activity History**.
95. Uncheck **Store my activity history on this device**.
96. Click **Clear** to clear the activity history, then click **Ok** in the popup that appears.
97. Click **Location**.
98. Click **Clear** to clear the location history from the system.
99. Set **Allow apps to access your location** to **Off**.
100. Click **Change** to change location access for the device and set **Location for this device** to **Off** in the popup, then click in the Location settings window to close the popup.
101. Click **Camera**.
102. Set camera access for all apps, including **Microsoft Edge**, **Desktop App Web Viewer**, and **Camera**, to **Off**.
103. Set **Allow apps to access your camera** to **Off**.
104. Click **Change** to change camera access for the device and set **Camera access for this device** to **Off** in the popup, then click in the Camera settings window to close the popup.
105. Click **Microphone**.
106. Set microphone access for all apps, including **Microsoft Edge** and **Camera**, to **Off**.
107. Set **Allow apps to access your microphone** to **Off**.
108. Click **Change** to change microphone access for the device and set **Microphone access for this device** to **Off** in the popup, then click in the Microphone settings window to close the popup.
109. Click **Notifications**.
110. Set **Allow apps to access your notifications** to **Off**.
111. Click **Change** to change notification access for the device and set **User notification access for this device** to **Off** in the popup, then click in the Notifications settings window to close the popup.
112. Click **Account info**.
113. Set account access for all apps, including **Microsoft Edge**, to **Off**.
114. Set **Allow apps to access your account info** to **Off**.
115. Click **Change** to change account info access for the device and set **Account info access for this device** to **Off** in the popup, then click in the Account info settings window to close the popup.
116. Click **Contacts**.
117. Set contacts access for all apps, including **Messaging** and **Mail and Calendar** to **Off**.
118. Set **Allow apps to access your contacts** to **Off**.
119. Click **Change** to change contacts access for the device and set **Contacts access for this device** to **Off** in the popup, then click in the Contacts settings window to close the popup.
120. Click **Calendar**.
121. Set calendar access for all apps, including **Mail and Calendar**, to **Off**.
122. Set **Allow apps to access your calendar** to **Off**.
123. Click **Change** to change calendar access for the device and set **Calendar access for this device** to **Off** in the popup, then click in the Calendar settings window to close the popup.
124. Click **Call History**.
125. Set **Allow apps to access your call history** to **Off**.
126. Click **Change** to change call history access for the device and set **Call history access for this device** to **Off** in the popup, then click in the Call history settings window to close the popup.
127. Click **Email**.
128. Set email access for all apps, including **Mail and Calendar**, to **Off**.
129. Set **Allow apps to access your email** to **Off**.
130. Click **Change** to change email access for the device and set **Email access for this device** to **Off** in the popup, then click in the Email settings window to close the popup.
131. Click **Tasks**.
132. Set **Allow apps to access your tasks** to **Off**.
133. Click **Change** to change tasks access for the device and set **Tasks access for this device** to **Off** in the popup, then click in the Tasks settings window to close the popup.
134. Click **Messaging**.
135. Set **Allow apps to read or send messages** to **Off**.
136. Click **Change** to change messaging access for the device and set **Messaging access for this device** to **Off** in the popup, then click in the Messaging settings window to close the popup.
137. Click **Radios**.
138. Set **Allow apps to control device radios** to **Off**.
139. Click **Change** to change access to control radios for the device and set **Access to control radios on this device** to **Off** in the popup, then click in the Radios settings window to close the popup.
140. Click **Other devices**.
141. Set **Communicate with unpaired devices** to **Off**.
142. Click **Background apps.**
143. Set background processing for all apps, including **Your Phone**, **Xbox**, **Windows Security**, **Voice Recorder**, **Sticky Notes**, **Snip & Sketch**, **Settings**, **Photos**, **People**, **Paint 3D**, **Movies & TV**, **Mixed Reality Viewer**, **Microsoft Store**, **Microsoft Edge**, **Messaging**, **Maps**, **Mail and Calendar**, **Groove Music**, **Get Help**, **Game bar**, **Connect**, **Camera**, **Calculator**, and **Alarms & Clock**, to **Off**.
144. Set **Let apps run in the background** to **Off**.
145. Click **App diagnostics**.
146. Set **Allow apps to access diagnostic info about your other apps** to **Off**.
147. Click **Change** to change app diagnostic info access for the device and set **App diagnostic access for this device** to **Off** in the popup, then click in the App diagnostics settings window to close the popup.
148. Click **Documents**.
149. Set document library access for **Voice Recorder** to **Off**.
150. Click **Pictures**.
151. Set pictures access for all apps, including **Xbox**, **Snip & Sketch**, **Paint 3D**, **Mixed Reality Viewer**, **Microsoft Edge**, **Game bar**, and **Cortana**, to **Off**.
152. Set **Allow apps to access your pictures library** to **Off**.
153. Click **Change** to change pictures library access for the device and set **Pictures library access for this device** to **Off** in the popup, then click in the Pictures settings window to close the popup.
154. Click **Videos**.
155. Set video library access for all apps, including **Xbox**, **Movies & TV**, **Mixed Reality Viewer**, **Game bar**, and **Camera**, to **Off**.
156. Set **Allow apps to access your videos library** to **Off**.
157. Click **Change** to change videos library access for this device and set **Videos library access for this device** to **Off** in the popup, then click in the Videos settings window to close the popup.
158. Click **File system**.
159. Set **Allow apps to access your file system** to **Off**.
160. Click **Change** to change file system access for the device and set **File system access for this device** to **Off** in the popup, then click in the File system settings window to close the popup.
161. Click **Home**.
162. Click **Update & Security**.
163. Click **Delivery Optimization**.
164. Set **Allow downloads from other PCs** to **Off**.
165. Close the Settings window by clicking the **Close (X)** button in the upper-right corner of the window.























































## Part 3 - Enable Hyper-V

1.  Right-click on the **Windows Start Menu** icon in the lower-left corner of the screen, then select **Run**.
2.  In the Run window that appears, enter `control panel` in the Open field and click **OK**.
3.  In the upper-right corner of the window that appears, from the View by pull down menu, select **Large icons**.
4.  Click on **Programs and Features**.
5.  In the Programs and Features window, click on **Turn Windows features on or off** in the left column.
6.  In the Windows Features window that appears, check the box to the left of **Hyper-V** and click **OK**.
7.  Windows will take a moment to enable Hyper-V, then will prompt you to restart the computer.  Click **Restart now**.

## Part 4 - Configure EFI 64-Bit Virtual Machine

1.  After the computer has restarted, click on the **Windows Start Menu** icon in the lower-left corner of the screen, then go to **Windows Administrative Tools** and select **Hyper-V Manager**.
2.  In the left column of the Hyper-V Manager, click on the name of your computer.
3.  In the right-most pane that appears, click **New** and click **Virtual Machine...**.
4.  In the New Virtual Machine Wizard, click **Next**.
5.  In the Name field, enter `WindowsEFI64`.
6.  Check the box next to **Store the virtual machine in a different location** and click the **Browse...** button.
7.  In the Select Folder window that appears, open the **Documents** folder for your Windows user account, and create a folder in Documents named `Virtual Machines`.
8.  Open the **Virtual Machines** folder, then click **Select Folder** to save the virtual machine in that folder.
9.  On the Specify Name and Location screen, click the **Next** button.
10. On the Specify Generation screen, choose **Generation 2** and click **Next**.
11. On the Assign Memory screen, specify `4096` MB as the Startup memory amount, ensure that **Use Dynamic Memory for this virtual machine** is checked, and click **Next**.
12. On the Configure Networking screen, ensure that Connection is set to **Not Connected**, then click **Next**.
13. On the Connect Virtual Hard Disk screen, ensure that **Create a virtual hard disk** is selected, then specify `64` GB as the Size and click **Next**.
14. On the Installation Options screen, click **Finish**.
15. In the Hyper-V Manager window, in the Virtual Machines pane, click **WindowsEFI64** to select it and in the right-most Actions pane, under WindowsEFI64, click **Settings...**.
16. In the window that appears, in the left column under Hardware, click on **Network Adapter** then click the **Remove** button.
17. In the left column, click **Memory**.
18. In the Memory pane on the right side of the window, enter `1024` as the Minimum RAM.
19. In the left column, click **SCSI Controller**.
20. In the SCSI Controller pane on the right side of the window, click **DVD Drive** then click **Add**.
21. In the DVD Drive pane that appears on the right, select **Image file** and click the **Browse...** button.
22. Select the **Windows1809.iso** file you downloaded in Part 1 and click **Open**.
23. In the left column, under the Management section, click on **Checkpoints**.
24. Uncheck **Enable checkpoints**.
25. Click the **OK** button.
26. To enable nested Hyper-V (allowing the Hyper-V client to also be a Hyper-V host), right-click on the **Windows Start Menu** icon on the host computer and select **Windows PowerShell (Admin)**.  In the PowerShell window that appears, enter `set-vmprocessor -vmname WindowsEFI64 -exposevirtualizationextensions $true` and press the **Enter** key.
27. Type `exit` and press the **Enter** key to close the PowerShell window.

## Part 5 - Boot The Windows Installer In The Virtual Machine

1.  In the Hyper-V Manager window, in the Virtual Machines pane, click on **WindowsEFI64**.
2.  In the right Actions pane, under WindowsEFI64, click **Start**.
3.  Wait a few moments while the virtual machine is started.  In the middle Virtual Machines tab, the WindowsEFI64 state should eventually change to Running.
4.  In the right Actions pane, under WindowsEFI64, click **Connect...**.
5.  Once the connection to the Virtual Machine is established, you should see a message indicating that No operating system was loaded.  Click in the virtual machine window to activate it.  Press the **Tab** key on the keyboard to highlight the **Restart now** button and press the **Enter** key.
6.  The virtual machine will restart and will display a message reading "Press any key to boot from CD or DVD..."  While this message is displayed, click the mouse inside the virtual machine window to activate it and then press the **A** key on the keyboard.  This sequence happens quickly and is time sensitive.  If the Windows Boot Manager screen does not appear, repeat step 5 and this step again until the black Windows Boot Manager screen appears.
7.  Until noted, the following procedure applies to actions inside the virtual machine environment.
8.  When the black Windows Boot Manager screen appears, ensure that **Windows 10 Setup (64-bit)** is selected, then press the **Enter** key.  Windows Setup will load.

## Part 6 - Install Windows In The Virtual Machine

1.  On the first Windows Setup screen, click the **Next** button.
2.  Click **Install now**.
3.  On the Activate Windows screen, click the **I don't have a product key** link.
4.  On the Select the operating system you want to install screen, select **Windows 10 Pro** and click the **Next** button.
5.  On the Applicable notices and license terms screen, check **I accept the license terms** and click **Next**.
6.  On the Which type of installation do you want screen, click **Custom: Install Windows only (advanced)**.
7.  Ensure that **Drive 0 Unallocated Space** is selected, then click **Next**.
8.  The Windows installation will begin.  Please wait while files are copied to the virtual machine's disk.  The virtual machine will automatically restart.
9.  Eventually, the Let's start with region screen will appear.

## Part 7 - Enable Windows Audit Mode

1.  To bypass the Windows configuration wizard and enter Audit Mode, press and hold the **Control** and **Shift** keys at the same time, then press the **F3** key (for a moment, all three keys should be pressed at the same time).  Release all the keyboard keys.
2.  The virtual machine will restart and will log the built-in Administrator account into Windows in Audit Mode.
3.  When Audit Mode starts, the system will automatically launch the System Preparation Tool 3.14 graphical interface.  Click **Cancel** to close the tool.
4.  Importantly, please note that Parts 8-15 must be completed without shutting down or restarting the virtual machine, as Windows will only allow customization of certain settings on the first boot.

## Part 8 - Disable Sounds

1.  Right-click on the **Windows Start Menu** icon in the lower-left corner of the screen and click **Run**.
2.  In the Open field, type `control panel` and press the **Enter** key.
3.  In the upper-right corner of the Control Panel window that appears, click on the **View by** pull down menu and click **Large icons** to switch from the Category option to Large icons.
4.  Click **Sound**.
5.  In the Sound window, go to the **Sounds** tab.
6.  Change Sound Scheme to **No Sounds**, then click the **OK** button.
7.  Click the **Close (X)** button in the upper-right corner of the All Control Panel Items window to close the window.

## Part 9 - Configure Settings

1.  Click on the **Windows Start Menu** icon in the lower-left corner of the screen, then **Settings** (gear icon).
2.  Go to **Personalization**.
3.  Go to **Colors**.
4.  Scroll down and set **Choose your default app mode** to **Dark**.
5.  Turn **Transparency effects** **Off**.
6.  Go to **Background**.
7.  Set **Background** to **Solid color**.
8.  Go to **Lock screen**.
9.  Set **Background** to **Picture**.
10. Set **Get fun facts, tips, and more from Windows and Cortana on your lock screen** to **Off**.
11. Go to **Themes**.
12. Click **Save theme**.
13. In the Save your theme popup that appears, in the Name your theme field, enter Default and click the **Save** button.
14. Go to **Start**.
15. Turn **Show recently added apps** **Off**.
16. Turn **Show suggestions occasionally in Start** **Off**.
17. Turn **Show recently opened items in Jump Lists on Start or the taskbar** **Off**.
18. Go to **Taskbar**.
19. Turn **Show badges on taskbar buttons** **Off**.
20. Click **Select which icons appear on the taskbar**.
21. Turn **Always show all icons in the notification area** **On**.
22. In the upper-left corner of the window, click the **Back** arrow button.
23. Go to **Turn system icons on or off**.
24. Set **Action Center**, **Location**, **Input indicator**, **Network** to **Off**.
25. In the upper-left corner of the window, click the **Back** arrow button.
26. Scroll down to the bottom of the window.
27. Turn **Show My People app suggestions** **Off**.
28. Turn **Play a sound when a My People notification arrives** **Off**.
29. Turn **Show My People notifications** **Off**.
30. Turn **Show contacts on the taskbar** **Off**.
31. In the upper-left corner of the window, click the **Home** button.
32. Click **System**.
33. Click **Notifications & actions**.
34. Click **Add or remove quick actions**.
35. Set **Tablet Mode**, **Location**, **VPN**, **Project**, and **Connect** to **Off**.
36. In the upper-left corner of the window, click the **Back** arrow button (the button may be difficult to see until the mouse is hovered over it).
37. Turn **Get notifications from apps and other senders** **Off**.
38. Turn **Get tips, tricks, and suggestions as you use Windows** **Off**.
39. Turn **Show me the Windows welcome experience after updates and occasionally when I sign in to highlight what's new and suggested** **Off**.
40. Click **Focus assist**.
41. Turn **When I'm playing a game** **Off**.
42. Turn **When I'm duplicating my display** **Off**.
43. Click **Tablet mode**.
44. Set **Hide app icons on the taskbar in tablet mode** to **Off**.
45. Set **When this device automatically switches tablet mode on or off** to **Don't ask me and don't switch**.
46. Set **When I sign in** to **Use desktop mode**.
47. Click **Multitasking**.
48. Set **Show suggestions occasionally in your timeline** to **Off**.
49. Click **Shared experiences**.
50. Set **Let apps on other devices (including linked phones and tablets) open and message apps on this device, and vice versa** to **Off**.
51. In the upper-left corner of the window, click **Home**.
52. Click **Devices**.
53. Click on **Printers & scanners**.
54. **Uncheck** **Let Windows manage my default printer**.
55. Click **Pen & Windows Ink**.
56. **Uncheck** **Show recommended app suggestions**.
57. Click **Home**.
58. Click **Apps**.
59. Set **Installing apps** to **Turn off app recommendations**.
60. Click on and **Uninstall** the following apps in the list: **App Installer**, **Feedback Hub**, **Microsoft OneDrive**, **Microsoft Solitaire Collection**, **Mixed Reality Portal**, **Mobile Plans**, **My Office**, **OneNote**, **Print 3D**, **Skype**, **Tips**, **Weather**, **Web Media Extensions**, **Xbox Live**.
61. Click **Offline Maps**.
62. Click **Delete all maps** and click **Delete all** in the popup that appears.
63. Set **Automatically update maps** to **Off**.
64. Click on **Apps for websites**.
65. Set **Microsoft Edge** and **Maps** (there may be two Maps listed, set them both) to **Off**.
66. Click **Startup**.
67. Set **Windows Security notification icon** to **Off**.
68. Click **Home**.
69. Click **Gaming**.
70. Turn **Record game clips, screenshots, and broadcast using Game bar** **Off.**
71. Uncheck **Open Game bar using this button on a controller**.
72. Click **Game Mode**.
73. Turn **Game Mode** **Off**.
74. Click **Home**.
75. Click **Cortana**.
76. Set **Use Cortana even when my device is locked** **Off**.
77. Click **Permissions & History**.
78. Click **Clear my device history**.
79. Set **My device history**, **Activity recommendations**, and **Windows Cloud Search** to **Off**.
80. Click **Home**.
81. Click **Privacy**.
82. Set **Let websites provide locally relevant content by accessing my language list**, **Let Windows track app launches to improve Start and search results**, **Show me suggested content in the Settings app** to **Off**.
83. Click **Inking & typing personalization**.
84. Set **Getting to know you** **Off**.
85. Click **Diagnostics & feedback**.
86. Set **Improve inking and typing** **Off**.
87. Click **Delete** to delete the diagnostic data from the system.
88. Set **Windows should ask for my feedback** to **Never**.
89. At the top of the screen, set **Diagnostic data** to **Basic**.
90. Click **Activity History**.
91. Uncheck **Store my activity history on this device**.
92. Click **Clear** to clear the activity history, then click **Ok** in the popup that appears.
93. Click **Location**.
94. Click **Clear** to clear the location history from the system.
95. Set **Allow apps to access your location** to **Off**.
96. Click **Change** to change location access for the device and set **Location for this device** to **Off** in the popup, then click in the Location settings window to close the popup.
97. Click **Camera**.
98. Set camera access for all apps, including **Microsoft Edge**, **Deluxe App Web Viewer**, and **Camera**, to **Off**.
99. Set **Allow apps to access your camera** to **Off**.
100. Click **Change** to change camera access for the device and set **Camera access for this device** to **Off** in the popup, then click in the Camera settings window to close the popup.
101. Click **Microphone**.
102. Set microphone access for all apps, including **Microsoft Edge** and **Camera**, to **Off**.
103. Set **Allow apps to access your microphone** to **Off**.
104. Click **Change** to change microphone access for the device and set **Microphone access for this device** to **Off** in the popup, then click in the Microphone settings window to close the popup.
105. Click **Notifications**.
106. Set **Allow apps to access your notifications** to **Off**.
107. Click **Change** to change notification access for the device and set **User notification access for this device** to **Off** in the popup, then click in the Notifications settings window to close the popup.
108. Click **Account info**.
109. Set account access for all apps, including **Microsoft Edge**, to **Off**.
110. Set **Allow apps to access your account info** to **Off**.
111. Click **Change** to change account info access for the device and set **Account info access for this device** to **Off** in the popup, then click in the Account info settings window to close the popup.
112. Click **Contacts**.
113. Set contacts access for all apps, including **Messaging** and **Mail and Calendar** to **Off**.
114. Set **Allow apps to access your contacts** to **Off**.
115. Click **Change** to change contacts access for the device and set **Contacts access for this device** to **Off** in the popup, then click in the Contacts settings window to close the popup.
116. Click **Calendar**.
117. Set calendar access for all apps, including **Mail and Calendar**, to **Off**.
118. Set **Allow apps to access your calendar** to **Off**.
119. Click **Change** to change calendar access for the device and set **Calendar access for this device** to **Off** in the popup, then click in the Calendar settings window to close the popup.
120. Click **Call History**.
121. Set **Allow apps to access your call history** to **Off**.
122. Click **Change** to change call history access for the device and set **Call history access for this device** to **Off** in the popup, then click in the Call history settings window to close the popup.
123. Click **Email**.
124. Set email access for all apps, including **Mail and Calendar**, to **Off**.
125. Set **Allow apps to access your email** to **Off**.
126. Click **Change** to change email access for the device and set **Email access for this device** to **Off** in the popup, then click in the Email settings window to close the popup.
127. Click **Tasks**.
128. Set **Allow apps to access your tasks** to **Off**.
129. Click **Change** to change tasks access for the device and set **Tasks access for this device** to **Off** in the popup, then click in the Tasks settings window to close the popup.
130. Click **Messaging**.
131. Set **Allow apps to read or send messages** to **Off**.
132. Click **Change** to change messaging access for the device and set **Messaging access for this device** to **Off** in the popup, then click in the Messaging settings window to close the popup.
133. Click **Radios**.
134. Set **Allow apps to control device radios** to **Off**.
135. Click **Change** to change access to control radios for the device and set **Access to control radios on this device** to **Off** in the popup, then click in the Radios settings window to close the popup.
136. Click **Other devices**.
137. Set **Communicate with unpaired devices** to **Off**.
138. Click **Background apps.**
139. Set background processing for all apps, including **Your Phone**, **Xbox**, **Windows Security**, **Voice Recorder**, **Sticky Notes**, **Snip & Sketch**, **Settings**, **Photos**, **People**, **Paint 3D**, **Movies & TV**, **Mixed Reality Viewer**, **Microsoft Store**, **Microsoft Edge**, **Messaging**, **Maps**, **Mail and Calendar**, **Groove Music**, **Get Help**, **Game bar**, **Connect**, **Camera**, **Calculator**, and **Alarms & Clock**, to **Off**.
140. Set **Let apps run in the background** to **Off**.
141. Click **App diagnostics**.
142. Set **Allow apps to access diagnostic info about your other apps** to **Off**.
143. Click **Change** to change app diagnostic info access for the device and set **App diagnostic access for this device** to **Off** in the popup, then click in the App diagnostics settings window to close the popup.
144. Click **Documents**.
145. Set document library access for all apps, including **Windows Security** and **Voice Recorder**, to **Off**.
146. Set **Allow apps to access your documents library** to **Off**.
147. Click **Change** to change documents library access for the device and set **Documents library access for this device** to **Off** in the popup, then click in the Documents settings window to close the popup.
148. Click **Pictures**.
149. Set pictures access for all apps, including **Xbox**, **Snip & Sketch**, **Paint 3D**, **Mixed Reality Viewer**, **Microsoft Edge**, **Game bar**, and **Cortana**, to **Off**.
150. Set **Allow apps to access your pictures library** to **Off**.
151. Click **Change** to change pictures library access for the device and set **Pictures library access for this device** to **Off** in the popup, then click in the Pictures settings window to close the popup.
152. Click **Videos**.
153. Set video library access for all apps, including **Xbox**, **Movies & TV**, **Mixed Reality Viewer**, **Game bar**, and **Camera**, to **Off**.
154. Set **Allow apps to access your videos library** to **Off**.
155. Click **Change** to change videos library access for this device and set **Videos library access for this device** to **Off** in the popup, then click in the Videos settings window to close the popup.
156. Click **File system**.
157. Set **Allow apps to access your file system** to **Off**.
158. Click **Change** to change file system access for the device and set **File system access for this device** to **Off** in the popup, then click in the File system settings window to close the popup.
159. Click **Home**.
160. Click **Update & Security**.
161. Click **Delivery Optimization**.
162. Set **Allow downloads from other PCs** to **Off**.
163. Close the Settings window by clicking the X close button in the upper-right corner of the window.
































## Part 8 - Enable Additional Windows Features

1.  Right-click on the **Windows Start Menu** icon in the lower-left corner of the screen and select **Windows PowerShell (Admin)**.
2.  In the PowerShell window that appears, to enable Microsoft Hyper-V, enter `dism /online /enable-feature /featurename:microsoft-hyper-v /norestart /all` and press the **Enter** key.
3.  Optionally, to enable the older .Net 3.5 framework, enter `dism /online /enable-feature /featurename:netfx3 /limitaccess /source:d:\x64\sources\sxs /norestart /all` and press the **Enter** key.
4.  Optionally, to enable the older SMB1 protocol (please note that enabling the SMB1 protocol can be a security risk), enter `dism /online /enable-feature /featurename:smb1protocol /norestart` and press the **Enter** key.  After the feature is enabled, enter `dism /online /disable-feature /featurename:smb1protocol-deprecation /norestart` and press the **Enter** key.   After the feature is disabled, enter `dism /online /disable-feature /featurename:smb1protocol-server /norestart` and press the **Enter** key.
5.  Type `exit` and press the **Enter** key to close the PowerShell window.

## Part 9 - Disable Server Service

1.  Right-click on the Start button in the lower-left corner of the screen and click **Computer Management**.
2.  In the Computer Management window, in the left column, under Computer Management (Local), double-click on **Services and Applications** to expand it.
3.  Double-click on **Services**, then, in the Services pane in the middle of the window, scroll down to the service named Server and double click on **Server** to open the Server service.
4.  In the Server Properties (Local Computer) window that appears, switch the Startup type pull down menu to **Disabled** and click the **Stop** button.
5.  Wait for the service to stop, then click the **OK** button to close the Server Properties (Local Computer) window.
6.  In the Computer Management window, click the **File** menu, then click **Exit** to close the Computer Management window.

## Part 10 - Configure Group Policies

1.  Right-click on the Start button in the lower-left corner of the screen and click **Run**.
2.  In the Run window that appears, in the Open field, type `gpedit.msc` and press the **Enter** key.
3.  In the Local Group Policy Editor window that appears, in the left column, under Local Computer Policy, Computer Configuration, double-click on **Administrative Templates** to expand it.
4.  Under the expanded Administrative Templates section in the left column, double-click **Windows Components** to expand it.
5.  Double-click **AutoPlay Policies**.
6.  In the AutoPlay Policies pane on the right of the window, double-click **Turn Off AutoPlay**.
7.  In the Turn Off AutoPlay window that appears, click the radio button to select **Enabled** then click the **OK** button.
8.  In the Local Group Policy Editor, in the left column, under Local Computer Policies, Computer Configuration, Administrative Templates, Windows Components, scroll down until Windows Update is visible (it may be necessary to maximize the window size and/or expand the left pane of the window to see read the names of the folders listed) and double-click **Windows Update**.
9.  In the Windows Update pane on the right of the window, double-click **Configure Automatic Updates**.
10. In the Configure Automatic Updates window that appears, click the radio button to select **Disabled** then click the **OK** button.
11. In the Local Group Policy Editor window, click the **File** menu, then click **Exit** to close the Local Group Policy Editor.

## Part 11 - Configure Control Panels

1.  Right-click on the **Windows Start Menu** icon in the lower-left corner of the screen and click **Run**.
2.  In the Open field, type `control panel` and press the **Enter** key.
3.  In the upper-right corner of the Control Panel window that appears, click on the **View by** pull down menu and click **Large icons** to switch from the Category option to Large icons.
4.  Click **AutoPlay**, uncheck **Use AutoPlay for all media and devices** and click the **Save** button.
5.  Click **Date and Time**, click **Change time zone...** select **(UTC-05:00) Eastern Time (US & Canada)** (or select the appropriate time zone for your location) and click the **OK** button.
6.  In the Date and Time window, uncheck **Notify me when the clock changes** and click the **OK** button.
7.  Click **File Explorer Options**.
8.  Change Open File Explorer to to **This PC**.
9.  Uncheck **Show recently used files in Quick access**.
10. Uncheck **Show frequently used files in Quick access**.
11. Click the **Clear** button.
12. Click the **View** tab at the top of the File Explorer Options window.
13. In the Advanced settings list, uncheck **Hide extensions for known file types**.
14. Scroll down in the Advanced settings list and uncheck **Use Sharing Wizard (Recommended)**.
15. Click the **OK** button to close the File Explorer Options window.
16. Click **Network and Sharing Center**.
17. In the left column of the Network and Sharing window, click **Change advanced sharing settings**.
18. In the Advanced sharing settings window, expand the **Private** section (click on the arrow to the right of the section heading) and uncheck **Turn on automatic setup of network connected devices**.
19. Click the radio button to select **Turn off network discovery** and click the **Save changes** button.
20. In the left column of the Network and Sharing Center window, click **Control Panel Home**.
21. Click **Power Options**.
22. To the right of Balanced (recommended) click **Change plan settings**.
23. Click **Change advanced power settings**.  Please note that different options may be available in this section depending upon whether your host device has battery power (e.g., a tablet or notebook computer) or if it is a desktop.  In some cases, there may be both On battery and Plugged in options available for settings.  In these cases, set all settings to the values indicated.
24. In the Power Options window that appears, double-click **Hard disk**, double-click **Turn off hard disk after**, and set all settings to `0/Never`.
25. If available, double-click **Wireless Adapter Settings**, double-click **Power Saving Mode**, and set all settings to **Maximum Power Saving**.
26. If available, double-click **Sleep**, double-click **Allow wake timers**, and set all settings to **Enable**.
27. Double-click **USB settings**, double-click **USB selective suspend setting**, and set all settings to **Disabled**.
28. If available, double-click **Power buttons and lid**, double-click **Power buton action**, to expand it and set all settings to **Shut down**.
29. Double-click **PCI Express**, double-click **Link State Power Management**, and set all settings to **Off**.
30. Double-click **Display**, double-click **Turn off display after**, and set all settings to `10` Minutes.
31. Double-click **Multimedia settings**.  Double-click **When sharing media** and set all settings to **Prevent idling to sleep**.  Double-click **Video playback quality bias** and set all settings to **Video playback performance bias**.  Double-click **When playing video** and set all settings to **Optimize video quality**.
32. Click the **OK** button.
33. At the top left of the Edit Plan Settings window, click the **Back** arrow button twice to return to the All Control Panel Items window.
34. Click **Sound**.
35. In the Sound window, go to the **Sounds** tab.
36. Change Sound Scheme to **No Sounds**, then click the **OK** button.
37. Click the **Close (X)** button in the upper-right corner of the All Control Panel Items window to close the window.

## Part 12 - Rename The Boot Volume

1.  Right-click on the **Windows Start Menu** icon in the lower-left corner of the screen and click **File Explorer**.
2.  Right-click on **Local Disk (C:)** and click **Rename**.
3.  Enter the drive name `Windows` and press the **Enter** key.
4.  Click the **File** menu in the upper-right corner of the screen, then click **Close**.

## Part 13 - Configure Settings

1.  Click on the **Windows Start Menu** icon in the lower-left corner of the screen, then **Settings** (gear icon).
2.  Go to **Personalization**.
3.  Go to **Colors**.
4.  Scroll down and set **Choose your default app mode** to **Dark**.
5.  Turn **Transparency effects** **Off**.
6.  Go to **Background**.
7.  Set **Background** to **Solid color**.
8.  Go to **Lock screen**.
9.  Set **Background** to **Picture**.
10. Set **Get fun facts, tips, and more from Windows and Cortana on your lock screen** to **Off**.
11. Go to **Themes**.
12. Click **Save theme**.
13. In the Save your theme popup that appears, in the Name your theme field, enter Default and click the **Save** button.
14. Go to **Start**.
15. Turn **Show recently added apps** **Off**.
16. Turn **Show suggestions occasionally in Start** **Off**.
17. Turn **Show recently opened items in Jump Lists on Start or the taskbar** **Off**.
18. Go to **Taskbar**.
19. Turn **Show badges on taskbar buttons** **Off**.
20. Click **Select which icons appear on the taskbar**.
21. Turn **Always show all icons in the notification area** **On**.
22. In the upper-left corner of the window, click the **Back** arrow button.
23. Go to **Turn system icons on or off**.
24. Set **Action Center**, **Location**, **Input indicator**, **Network** to **Off**.
25. In the upper-left corner of the window, click the **Back** arrow button.
26. Scroll down to the bottom of the window.
27. Turn **Show My People app suggestions** **Off**.
28. Turn **Play a sound when a My People notification arrives** **Off**.
29. Turn **Show My People notifications** **Off**.
30. Turn **Show contacts on the taskbar** **Off**.
31. In the upper-left corner of the window, click the **Home** button.
32. Click **System**.
33. Click **Notifications & actions**.
34. Click **Add or remove quick actions**.
35. Set **Tablet Mode**, **Location**, **VPN**, **Project**, and **Connect** to **Off**.
36. In the upper-left corner of the window, click the **Back** arrow button (the button may be difficult to see until the mouse is hovered over it).
37. Turn **Get notifications from apps and other senders** **Off**.
38. Turn **Get tips, tricks, and suggestions as you use Windows** **Off**.
39. Turn **Show me the Windows welcome experience after updates and occasionally when I sign in to highlight what's new and suggested** **Off**.
40. Click **Focus assist**.
41. Turn **When I'm playing a game** **Off**.
42. Turn **When I'm duplicating my display** **Off**.
43. Click **Tablet mode**.
44. Set **Hide app icons on the taskbar in tablet mode** to **Off**.
45. Set **When this device automatically switches tablet mode on or off** to **Don't ask me and don't switch**.
46. Set **When I sign in** to **Use desktop mode**.
47. Click **Multitasking**.
48. Set **Show suggestions occasionally in your timeline** to **Off**.
49. Click **Shared experiences**.
50. Set **Let apps on other devices (including linked phones and tablets) open and message apps on this device, and vice versa** to **Off**.
51. In the upper-left corner of the window, click **Home**.
52. Click **Devices**.
53. Click on **Printers & scanners**.
54. **Uncheck** **Let Windows manage my default printer**.
55. Click **Pen & Windows Ink**.
56. **Uncheck** **Show recommended app suggestions**.
57. Click **Home**.
58. Click **Apps**.
59. Set **Installing apps** to **Turn off app recommendations**.
60. Click on and **Uninstall** the following apps in the list: **App Installer**, **Feedback Hub**, **Microsoft OneDrive**, **Microsoft Solitaire Collection**, **Mixed Reality Portal**, **Mobile Plans**, **My Office**, **OneNote**, **Print 3D**, **Skype**, **Tips**, **Weather**, **Web Media Extensions**, **Xbox Live**.
61. Click **Offline Maps**.
62. Click **Delete all maps** and click **Delete all** in the popup that appears.
63. Set **Automatically update maps** to **Off**.
64. Click on **Apps for websites**.
65. Set **Microsoft Edge** and **Maps** (there may be two Maps listed, set them both) to **Off**.
66. Click **Startup**.
67. Set **Windows Security notification icon** to **Off**.
68. Click **Home**.
69. Click **Gaming**.
70. Turn **Record game clips, screenshots, and broadcast using Game bar** **Off.**
71. Uncheck **Open Game bar using this button on a controller**.
72. Click **Game Mode**.
73. Turn **Game Mode** **Off**.
74. Click **Home**.
75. Click **Cortana**.
76. Set **Use Cortana even when my device is locked** **Off**.
77. Click **Permissions & History**.
78. Click **Clear my device history**.
79. Set **My device history**, **Activity recommendations**, and **Windows Cloud Search** to **Off**.
80. Click **Home**.
81. Click **Privacy**.
82. Set **Let websites provide locally relevant content by accessing my language list**, **Let Windows track app launches to improve Start and search results**, **Show me suggested content in the Settings app** to **Off**.
83. Click **Inking & typing personalization**.
84. Set **Getting to know you** **Off**.
85. Click **Diagnostics & feedback**.
86. Set **Improve inking and typing** **Off**.
87. Click **Delete** to delete the diagnostic data from the system.
88. Set **Windows should ask for my feedback** to **Never**.
89. At the top of the screen, set **Diagnostic data** to **Basic**.
90. Click **Activity History**.
91. Uncheck **Store my activity history on this device**.
92. Click **Clear** to clear the activity history, then click **Ok** in the popup that appears.
93. Click **Location**.
94. Click **Clear** to clear the location history from the system.
95. Set **Allow apps to access your location** to **Off**.
96. Click **Change** to change location access for the device and set **Location for this device** to **Off** in the popup, then click in the Location settings window to close the popup.
97. Click **Camera**.
98. Set camera access for all apps, including **Microsoft Edge**, **Deluxe App Web Viewer**, and **Camera**, to **Off**.
99. Set **Allow apps to access your camera** to **Off**.
100. Click **Change** to change camera access for the device and set **Camera access for this device** to **Off** in the popup, then click in the Camera settings window to close the popup.
101. Click **Microphone**.
102. Set microphone access for all apps, including **Microsoft Edge** and **Camera**, to **Off**.
103. Set **Allow apps to access your microphone** to **Off**.
104. Click **Change** to change microphone access for the device and set **Microphone access for this device** to **Off** in the popup, then click in the Microphone settings window to close the popup.
105. Click **Notifications**.
106. Set **Allow apps to access your notifications** to **Off**.
107. Click **Change** to change notification access for the device and set **User notification access for this device** to **Off** in the popup, then click in the Notifications settings window to close the popup.
108. Click **Account info**.
109. Set account access for all apps, including **Microsoft Edge**, to **Off**.
110. Set **Allow apps to access your account info** to **Off**.
111. Click **Change** to change account info access for the device and set **Account info access for this device** to **Off** in the popup, then click in the Account info settings window to close the popup.
112. Click **Contacts**.
113. Set contacts access for all apps, including **Messaging** and **Mail and Calendar** to **Off**.
114. Set **Allow apps to access your contacts** to **Off**.
115. Click **Change** to change contacts access for the device and set **Contacts access for this device** to **Off** in the popup, then click in the Contacts settings window to close the popup.
116. Click **Calendar**.
117. Set calendar access for all apps, including **Mail and Calendar**, to **Off**.
118. Set **Allow apps to access your calendar** to **Off**.
119. Click **Change** to change calendar access for the device and set **Calendar access for this device** to **Off** in the popup, then click in the Calendar settings window to close the popup.
120. Click **Call History**.
121. Set **Allow apps to access your call history** to **Off**.
122. Click **Change** to change call history access for the device and set **Call history access for this device** to **Off** in the popup, then click in the Call history settings window to close the popup.
123. Click **Email**.
124. Set email access for all apps, including **Mail and Calendar**, to **Off**.
125. Set **Allow apps to access your email** to **Off**.
126. Click **Change** to change email access for the device and set **Email access for this device** to **Off** in the popup, then click in the Email settings window to close the popup.
127. Click **Tasks**.
128. Set **Allow apps to access your tasks** to **Off**.
129. Click **Change** to change tasks access for the device and set **Tasks access for this device** to **Off** in the popup, then click in the Tasks settings window to close the popup.
130. Click **Messaging**.
131. Set **Allow apps to read or send messages** to **Off**.
132. Click **Change** to change messaging access for the device and set **Messaging access for this device** to **Off** in the popup, then click in the Messaging settings window to close the popup.
133. Click **Radios**.
134. Set **Allow apps to control device radios** to **Off**.
135. Click **Change** to change access to control radios for the device and set **Access to control radios on this device** to **Off** in the popup, then click in the Radios settings window to close the popup.
136. Click **Other devices**.
137. Set **Communicate with unpaired devices** to **Off**.
138. Click **Background apps.**
139. Set background processing for all apps, including **Your Phone**, **Xbox**, **Windows Security**, **Voice Recorder**, **Sticky Notes**, **Snip & Sketch**, **Settings**, **Photos**, **People**, **Paint 3D**, **Movies & TV**, **Mixed Reality Viewer**, **Microsoft Store**, **Microsoft Edge**, **Messaging**, **Maps**, **Mail and Calendar**, **Groove Music**, **Get Help**, **Game bar**, **Connect**, **Camera**, **Calculator**, and **Alarms & Clock**, to **Off**.
140. Set **Let apps run in the background** to **Off**.
141. Click **App diagnostics**.
142. Set **Allow apps to access diagnostic info about your other apps** to **Off**.
143. Click **Change** to change app diagnostic info access for the device and set **App diagnostic access for this device** to **Off** in the popup, then click in the App diagnostics settings window to close the popup.
144. Click **Documents**.
145. Set document library access for all apps, including **Windows Security** and **Voice Recorder**, to **Off**.
146. Set **Allow apps to access your documents library** to **Off**.
147. Click **Change** to change documents library access for the device and set **Documents library access for this device** to **Off** in the popup, then click in the Documents settings window to close the popup.
148. Click **Pictures**.
149. Set pictures access for all apps, including **Xbox**, **Snip & Sketch**, **Paint 3D**, **Mixed Reality Viewer**, **Microsoft Edge**, **Game bar**, and **Cortana**, to **Off**.
150. Set **Allow apps to access your pictures library** to **Off**.
151. Click **Change** to change pictures library access for the device and set **Pictures library access for this device** to **Off** in the popup, then click in the Pictures settings window to close the popup.
152. Click **Videos**.
153. Set video library access for all apps, including **Xbox**, **Movies & TV**, **Mixed Reality Viewer**, **Game bar**, and **Camera**, to **Off**.
154. Set **Allow apps to access your videos library** to **Off**.
155. Click **Change** to change videos library access for this device and set **Videos library access for this device** to **Off** in the popup, then click in the Videos settings window to close the popup.
156. Click **File system**.
157. Set **Allow apps to access your file system** to **Off**.
158. Click **Change** to change file system access for the device and set **File system access for this device** to **Off** in the popup, then click in the File system settings window to close the popup.
159. Click **Home**.
160. Click **Update & Security**.
161. Click **Delivery Optimization**.
162. Set **Allow downloads from other PCs** to **Off**.
163. Close the Settings window by clicking the X close button in the upper-right corner of the window.

## Part 14 - Customize Destop, Taskbar, Start Menu, And Internet Explorer

1.  Right-click on the **Microsoft Edge** shortcut on the Desktop and click **Delete**.
2.  Right-click on an empty area of the Taskbar (e.g., 2/3 of the way from the bottom-left of the screen to the bottom-right of the screen on an empty black area between the yellow File Explorer folder icon and the white Windows Defender System Tray icon).
3.  In the context menu that appears, click **Cortana** then click **Hidden**.
4.  Click on the **Start** icon in the lower-left corner of the screen.
5.  For each of the tiles on the right side of the Start Menu, right-click on the tile and click **Unpin from Start**.
6.  In the Application List on the left side of the Start Menu, right-click on **Calculator**.
7.  Click **Pin to Start**.
8.  Right-click on the **Calculator** tile on the right side of the Start Menu and click **More**, then click **Turn Live Tile off**.
9.  Right-click on the **Calculator** tile on the right side of the Start Menu and click **Resize**, then click **Small**.
10. Scroll in the Application List on the left side of the Start Menu down to Windows Accessories and click on **Windows Accessories**.
11. Click on **Internet Explorer**.
12. In the Internet Explorer 11 window that appears, click the radio button to select **Don't use recommended settings** and click the **OK** button.
13. Click on the **Tools** (gear icon) menu in the upper-right corner of the Internet Explorer window and click **Internet Options**.
14. In the Internet Options window that appears, in the Home page field, erase the URL listed and enter about:blank.
15. Click the **Tabs** button and in the Tabbed Browsing Settings window that appears, change the **When a new tab is opened, open:** field to **A blank page** and click the **OK** button.
16. Back in the Internet Options window, click the **OK** button.
17. Click the **View favorites, feeds, and history** (star) icon in the upper-right of the Internet Explorer window.
18. Right-click on the **Bing** icon and click **Delete**.
19. Click on the **Tools** (gear icon) menu in the upper-right corner of the Internet Explorer window and click **Safety** then click **Delete browsing history...**.
20. Uncheck **Preserve Favorites website data** and check **Download History**, **Form data**, **Passwords**, and **Tracking Protection, ActiveX Filtering and Do Not Track** and click the **Delete** button.
21. Close the Internet Explorer window by clicking the X close button in the upper-right corner of the window.
22. When prompted, click **Close all tabs**.
23. Click the Start icon in the lower-left corner of the screen, scroll down the Application List on the left side of the Start Menu and click on **Windows Accessories**, and click **Internet Explorer**.
24. Close the Internet Explorer window by clicking the X close button in the upper-right corner of the window.
25. When prompted, click **Close all tabs**.
26. Click the Start icon in the lower-left corner of the screen, scroll down the Application List on the left side of the Start Menu and click on **Windows Accessories**, and click **Internet Explorer**.
27. Close the Internet Explorer window by clicking the X close button in the upper-right corner of the window.
28. Right-click on **Recycle Bin** on the Desktop and click **Empty Recycle Bin**.
29. Click **Yes** to confirm deletion.

## Part 15 - Export Start Menu

1.  Right-click on the **Windows Start Menu** icon in the lower-left corner of the screen and click **Windows PowerShell (Admin)**.
2.  Type export-startlayout -path c:\StartLayout.xml and press the **Enter** key.
3.  Type exit and press the **Enter** key to exit PowerShell.
4.  Click the **File Explorer** (yellow folder) icon on the Taskbar towards the lower-left corner of the screen.
5.  Double-click on **Windows (C:)**.
6.  Right-click on **StartLayout.xml** and click **Cut**.
7.  Double-click on **Users**.
8.  Double-click on **Public**.
9. Right-click on an empty area of the Public folder and click **New**, then click **Folder**.
10. Name the new folder Settings.
11. Double-click on **Settings**.
12. Right-click on an empty area of the Settings folder and click **Paste**.
13. Right-click on **StartLayout.xml**, click **Open with**, and click **Notepad**.
14. Edit the **<DefaultLayoutOverride>** tag to read <DefaultLayoutOverride LayoutCustomizationRestrictionType="OnlySpecifiedGroups">.
15. Click the **File** menu, click **Exit** and when prompted, click **Save**.
16. Close the File Explorer window by clicking the X close button in the upper-right corner of the window.

PART 16 - RESTART THE VIRTUAL MACHINE

1.  Click the Start icon in the lower-left corner of the screen, click the **Power** button, and click **Restart**.
2.  The system may restart one or more times and will eventually restart in Audit Mode.
3.  When Audit Mode starts, the system will automatically launch the System Preparation Tool 3.14 graphical interface.  Click **Cancel** to close the tool.

PART 17 - SHUTDOWN THE VIRTUAL MACHINE

1.  Click the Start icon in the lower-left corner of the screen, click the **Power** button, and click **Shut down**.

PART 18 - EXPORT THE VIRTUAL MACHINE AND CREATE A BACKUP DISK

1.  Until noted, the following procedure applies to actions inside the host environment.
2.  In the WindowsEFI Virtual Machine Connection window, click on the **File** menu, then click **Settings...**.
3.  In the left column of the Settings for WindowsEFI64 window, under Hardware, SCSI Controller, click on **DVD Drive**.
4.  In the right pane of the window, click **Remove** to remove the DVD drive from the virtual machine.
5.  Click **OK** in the lower-right corner of the window.
6.  Click on the **Action** menu, then click **Share...**.
7.  In the Save As window that appears, open your Windows user account **Documents** folder, then enter WindowsEFI64.vmcz in the File name field and click **Save**.
8.  A green progress bar will appear on the bottom of the Virtual Machine Connection window and it may take a few moments to export the virtual machine.
9.  Once the virtual machine export is complete, click on the **File** menu, then click **Settings...**.
10. In the left column of the Settings for WindowsEFI64 window, under Hardware, click **SCSI Controller**.
11. In the pane on the right side of the window, click on **DVD Drive** to select it, then click **Add**.
12. In the pane on the right side of the window, the DVD Drive options should appear.  Click to select **Image file**, then click the **Browse** button and open the Windows1809.iso file on your computer.
13. In the left column of the Settings for WindowsEFI64 window, under Hardware, click **SCSI Controller**.
14. In the pane on the right side of the window, click on **Hard Drive** to select it, then click **Add**.
15. The Hard Drive options appear on the right side of the window.  In the Media section, with **Virtual hard disk** selected, click the **New** button.
16. In the New Virtual Hard Disk Wizard that appears, click **Next**.
17. On the Choose Disk Type screen, select **Fixed Size** and click **Next**.
18. On the Specify Name and Location screen, in the Name field, enter Backup.vhdx as the file name.
19. Click the **Browse** button.  Navigate to your Windows user account's Documents folder.  Create a new folder in Documents named Virtual Disks.
20. Open the **Virtual Disks** folder and click **Select Folder**.
21. On the Specify Name and Location screen, click **Next**.
22. On the Configure Disk screen, enter 20 GB as the Size and click **Finish**.  It may take a moment for the system to create the virtual disk.

23. In the Settings for WindowsEFI64 window, click **Apply**.
24. In the left column of the window, under Hardware, click on **Firmware**.
25. In the pane on the right side of the window, in the Boot order section, click on **DVD Drive** to select it in the list, then click the **Move Up** button repeatedly until the DVD Drive is at the top of the list.
26. Click **OK**.
27. In the Virtual Machine Connection window, click the Start button.
28. The virtual machine will start and will display a message reading "Press any key to boot from CD or DVD..."  While this message is displayed, click the mouse inside the virtual machine window to activate it and then press the **A** key on the keyboard.  This sequence happens quickly and is time sensitive.  If the Windows Boot Manager screen does not appear, wait until Windows starts in Audit Mode, in the System Preparation Tool 3.14 click **Cancel**, then click the Start icon in the lower-left corner of the screen, click the **Power** button, and click **Shut down**.  After the virtual machine has shut down, repeat step 27 and 28 until the black Windows Boot Manager screen appears.
29. Until noted, the following procedure applies to actions inside the virtual machine environment.

PART 19 - CAPTURE AN IMAGE OF THE VIRTUAL MACHINE

1.  When the black Windows Boot Manager screen appears, ensure that **Windows 10 Setup (64-bit)** is selected, then press the **Enter** key.  Windows Setup will load.
2.  In the Windows Setup window that appears, click **Next**.
3.  Click **Repair your computer**.
4.  Click **Troubleshoot**.
5.  Click **Command Prompt**.
6.  In the Command Prompt window that appears, type diskpart and press the **Enter** key.
7.  At the DISKPART> prompt, type list disk.  Two disks should be listed.  Note which disk does not have a * character in the Gpt column (it is likely that Disk 1 does not have a * character in the Gpt column and the below instructions assume this; if the disk without the * character has a different disk number on your system, substitute that disk number in the instructions below).
8.  Type  select disk 1 and press the **Enter** key.
9.  Type clean and press the **Enter** key.
10. Type create partition primary and press the **Enter** key.
11. Type format fs=ntfs quick label=Backup and press the **Enter** key.
12. Type assign and press the **Enter** key.
13. Type list volume and press the **Enter** key.
14. Note the drive letter of the Backup volume (likely drive E) and the drive letter of the Windows volume (likely drive C).  If the drive letters are not E and C, respectively, please substitute the drive letters for your system in the command below.

15. Type exit and press the **Enter** key.
16. Type dism /capture-image /capturedir:c:\ /imagefile:e:\WindowsEFI64AuditMode.wim /name:Audit (be sure to substitute the correct drive letters in the command) and press the **Enter** key.
17. When the image capture has completed, type exit and press the **Enter** key.
18. On the Choose an option screen, click **Turn off your PC** and wait a moment as the virtual machine stops.
19. Until noted, the following procedure applies to actions inside the host environment.
20. In the Virtual Machine Connection window, click the **File** menu, then click **Exit**.
21. In the Hyper-V Manager, in the Actions pane on the right side of the window, click on **Virtual Switch Manager**.
22. On the right side of the Virtual Switch Manager window that appears, with **External** selected, click **Create Virtual Switch**.
23. In the Virtual Switch Properties, enter External in the Name field.  Ensure that the pull down menu under Connection type, External network is set to the network adapter on your host computer that is used for network access, then click **OK**.
24. Click **Yes** in the Apply Networking Changes dialog.
25. In the Hyper-V Manager window, click on the **File** menu, then click **Exit**.

PART 20 - IMPORT THE VIRTUAL MACHINE AND CONNECT THE BACKUP DISK

1.  Open Windows File Explorer and open your Documents folder.
2.  Locate the WindowsEFI64.vmcz file and double-click on it to import the virtual machine copy.
3.  In the User Account Control dialog that appears, click **Yes**.
4.  On the Import Virtual Machine screen that appears, click the **Import Virtual Machine** button.
5.  It will likely take a few moments for the system to import the virtual machine.
6.  When the import completes, you will see a message reading Virtual machine created successfully.  The new virtual machine will be named WindowsEFI64 (1).

7.  Click the **Edit settings...** button.
8.  In the Settings for WindowsEFI64 (1) window that appears, in the left column, under hardware, click on **SCSI Controller**.
9.  In the right pane of the window, click on **Hard Drive** to select it, then click on the **Add** button.
10. On the Hard Drive screen, under Media, with Virtual hard disk selected, click **Browse**.
11. Navigate to the Documents folder for your Windows user account, open the Virtual Disks folder, then double-click on **Backup.vhdx** to open it.
12. In the left column of the Settings for WindowsEFI64 (1) window, under Hardware, click **Add Hardware**.
13. In the pane on the right side of the window, click **Network Adapter** and click **Add**.
14. On the Network Adapter screen, from the Virtual switch pull down menu, select **External**.

15. In the Settings for WindowsEFI64 (1) window, click **OK**.
16. In the Import Virtual Machine window, click **Connect**.
17. In the Virtual Machine Connection window, click **Start**.
18. Click in the virtual machine window to activate it.
19. Until noted, the following procedure applies to actions inside the virtual machine environment.

PART 21 - ENABLE FILE SHARING ON THE VIRTUAL MACHINE

1.  Once Windows starts, a blue message on the right side of the screen will prompt Do you want to allow your PC to be discoverable by other PCs and devices on this network?  Click **Yes**.

2.  In the System Preparation Tool 3.14 window, click **Cancel**.
3.  Right-click on the **Windows Start Menu** icon in the lower-left corner of the screen and click **Computer Management**.
4.  In the left column of the Computer Management window, under Computer Management (Local), System Tools, double-click on Local Users and Groups, then double-click on Users.
5.  Click the **Action** menu, then click **New User...**.
6.  Enter transfer as the user name and enter a secure password for the user in both the Password and confirm password fields.
7.  Uncheck **User must change password at next logon**, and check **Password never expires**.
8.  Click **Create**.
9.  Click **Close**.

10. In the left column of the Computer Management window, under Computer Management (Local), Services and Applications, double-click on **Services**.
11. In the middle pane of the window, scroll down in the Services list and locate Server, then double-click on **Server**.
12. Set the Startup type for Server to **Automatic** and click the **Start** button, then click **OK**.
13. Go to the **File** menu and click **Exit**.
14. Right-click on an empty area of the Desktop and click **New** then click **Folder**.
15. Name the folder share.
16. Right-click on the **share** folder and click **Properties**.
17. In the Share Properties window that appears, click on the **Sharing** tab.
18. Click **Advanced Sharing**.
19. Check **Share this folder**.
20. Click **Permissions**.
21. Click **Add**.
22. In the Enter the object names to select field, enter transfer and click **Check Names**.  The name should resolve to COMPUTERNAME\transfer (where COMPUTERNAME is the current vm pseudo-random name).
23. Click **OK**.

24. In the Permissions for share window, with **transfer** selected, click the **Allow Full Control** checkbox.
25. Click **OK**.
26. Click **OK**.
27. Click on the **Security** tab.
28. Click **Edit**.
29. Click **Add**.
30. In the Enter the object names to select, enter transfer and click **Check Names**.
31. Click **OK**.
32. In the Permissions for share window, click on **transfer** in the Group or user names list, then click **Allow Full control**.  Click the **OK** button.

33. Click **Close**.
34. Right-click on the **Windows Start Menu** icon in the lower-left corner and click **Windows PowerShell (Admin)**.
35. In the PowerShell Window, type ipconfig and press the **Enter** key.
36. Note the IPv4 Address indicated for the virtual machine.
37. Type exit and press the **Enter** key.
38. Open the Windows File Explorer and open the Backup disk (likely drive letter D).
39. Right-click on the **WindowsEFIAuditMode.wim** file and click **Copy**.
40. Open the **Desktop** folder, then open the **share** folder, then right-click on an empty area of the folder window and click **Paste**.
41. Until noted, the following procedure applies to actions inside the host environment.
42. Click on the Minimize (-) button in the upper-right corner of the WindowsEFI64 (1) Virtual Machine Connection window to minimize the window.
43. Open Windows File Explorer on the host and go to **This PC**.
44. Click **Computer** and then **Map network drive**.
45. In the Map Network Drive window that appears, in the Folder field, enter \\IPAddressOfVirtualMachine\share (where IPAddressOfVirtualMachine is the IP address noted in step 30).  Note the drive letter for the mapped drive (likely drive Z:).

46. Uncheck **Reconnect at sign-in** and click **Finish**.
47. In the Enter network credentials window that appears, enter transfer in the User name field and the password you created in the Password field, then click **OK**.
48. In the share folder that opens, right-click on **WindowsEFI64AuditMode.wim** and click **Copy**.
49. Navigate to the Documents folder for your Windows user account, right-click in an empty area of the folder, and click **Paste**.

PART 22 - CREATE A COPYPROFILE ANSWER FILE

1.  Click on the **Windows Start Menu** icon, click **Windows Kits** and click **Windows System Image Manager**.

2.  In the Windows System Image Manager, click the **File** menu, click **Select Windows Image**.
3.  Navigate to the Documents folder and double-click on **WindowsEFI64AuditMode.wim**.
4.  When asked Do you want to create a catalog file, click **Yes**.
5.  In the User Account Control dialog that appears, click **Yes**.
6.  The system may take a moment to create a catalog file.
7.  Once the catalog file is created, in the Windows Image pane, expand **Components**, then right-click on **amd64_Microsoft-Windows-Shell-Setup_10.0.17763.1_neutral** and click **Add Setting to Pass 4 specialize**.
8.  In the Answer File pane, select **Components**, **4 specialize**, **amd64-Microsoft-Windows-Shell-Setup_neutral**.
9.  In the Microsoft-Windows-Shell-Setup Properties pane, in the Settings section, click on **CopyProfile**, then select **true** from the pull down menu to the right of CopyProfile.
10. Go to the **File** menu and click **Save Answer File As...**.
11. In the Save As window that appears, open the **Documents** folder for your Windows user account and then enter CopyProfile.xml in the File name field and click **Save**.
12. Go to the **File** menu and click **Exit**.

PART 23 - COPY THE ANSWER FILE TO THE VIRTUAL DISK

1.  Open the Windows File Explorer and open your Windows user account's **Documents** folder.
2.  Right-click on the **CopyProfile.xml** file and click **Copy**.
3.  Navigate to the mapped **share** folder from the virtual machine (the location should have been noted in step 45 of Part 21 and is likely drive Z:).
4.  Right-click in an empty area of the open share folder and click **Paste**.
5.  In the Windows File Explorer, open the **File** menu and click **Close**.
6.  Open the WindowsEFI64 (1) Virtual Machine Connection window and click in the window to activate it.

7.  Until noted, the following procedure applies to actions inside the virtual machine environment.
8.  Open Windows File Explorer and open the **share** folder on the Administrator account's Desktop.
9.  Right-click on the **CopyProfile.xml** file and click **Copy**.
10. Open **This PC**.
11. Open the **Backup** disk (likely D:).
12. Right-click in an empty area of the open file browser window and click **Paste**.
13. Click the **X Close** button in the upper-right corner of the window to close the file browser.
14. Click on the **Windows Start Menu** icon then click **Power**, then click **Shut Down**.
15. Until noted, the following procedure applies to actions inside the host environment.
16. Click the **X Close** button in the upper-right corner of the WindowsEFI64 (1) Virtual Machine Connection window to close it.
17. In the Hyper-V Manager window, in the Virtual Machines pane, click on the **WindowsEFI64** virtual machine to select it.
18. In the Actions pane on the right side of the window, under WindowsEFI64, click **Connect...**.
19. In the WindowsEFI64 Virtual Machine Connection window that appears, click the **Start** button.
20. After the virtual machine starts and boots into Window Audit Mode, click the mouse cursor in the virtual machine window to activate it.
21. Until noted, the following procedure applies to actions inside the virtual machine environment.

PART 24 - RUN SYSPREP

1.  In System Preparation Tool 3.14, click **Cancel**.

2.  Right-click on the **Windows Start Menu** icon and click **Windows PowerShell (Admin)**.
3.  Type del (Get-PSReadlineOption).HistorySavePath and press the **Enter** key.
4.  Close the PowerShell window by clicking the **X Close** button in the upper-right corner of the window.
5.  Click the **File Explorer** (yellow folder) icon on the Taskbar and go to **This PC**.
6.  Note the drive letter for the Backup drive (likely E:).
7.  Close File Explorer by clicking on the **X Close** button in the upper-right corner of the window.
8.  Right-click on the **Windows Start Menu** icon and click **Run**.
9.  In the Open field, type c:\windows\system32\sysprep\sysprep.exe /generalize /oobe /shutdown /unattend:e:\copyprofile.xml (substituting the correct letter if e: is not the drive letter for the backup drive noted in step 6) and press the **Enter** key.
10. A message reading Sysprep is working... will appear.  Wait while the Sysprep program finishes running and the virtual machine is shut down.
11. Until noted, the following procedure applies to actions inside the host environment.

PART 25 - CAPTURE POST-SYSPREP IMAGE

1.  In the WindowsEFI64 Virtual Machine Connection window, click the **File** menu, then click **Exit**.
2.  In the Hyper-V Manager window, in the Virtual Machines pane, click on **WindowsEFI64 (1)** to select it.
3.  In the Actions pane on the right side of the window, under WindowsEFI64 (1), click **Connect...**.
4.  In the WindowsEFI64(1) Virtual Machine Connection window that appears, click the **File** menu, then click **Settings**.
5.

6.  , then click

7.  , click the Start button.
8.  The virtual machine will start and will display a message reading "Press any key to boot from CD or DVD..."  While this message is displayed, click the mouse inside the virtual machine window to activate it and then press the **A** key on the keyboard.  This sequence happens quickly and is time sensitive.  If the Windows Boot Manager screen does not appear, wait until Windows starts in Audit Mode, in the System Preparation Tool 3.14 click **Cancel**, then click the Start icon in the lower-left corner of the screen, click the **Power** button, and click **Shut down**.  After the virtual machine has shut down, repeat step 27 and 28 until the black Windows Boot Manager screen appears.
9.  Until noted, the following procedure applies to actions inside the virtual machine environment.






































## License

All content copyright (c) 2018 Curtis Glavin, Jonathan Huppi, Robert Burkey

All code in this repository is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3 as published by the Free Software Foundation.

All code in this repository is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

A copy of the GNU General Public License version 3 is available [in this repository](https://raw.githubusercontent.com/pedonc/windows-deployment/master/LICENSE) and from the Free Software Foundation at [https://www.gnu.org/licenses/gpl-3.0.txt](https://www.gnu.org/licenses/gpl-3.0.txt).

All documentation in this repository is licensed under the GNU Free Documentation License version 1.3.

Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.3 or any later version published by the Free Software Foundation; with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.  A copy of the license is included in the section entitled "GNU Free Documentation License".  Additionally, a copy of the license is available [in this repository](https://raw.githubusercontent.com/pedonc/windows-deployment/master/fdl.txt) and from the Free Software Foundation at [https://www.gnu.org/licenses/fdl.txt](https://www.gnu.org/licenses/fdl.txt).

## GNU Free Documentation License

Version 1.3, 3 November 2008

Copyright © 2000, 2001, 2002, 2007, 2008 Free Software Foundation, Inc. <https://fsf.org/>

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

You may add a section Entitled "Endorsements", provided it contains nothing but endorsements of your Modified Version by various parties—for example, statements of peer review or that the text has been approved by an organization as the authoritative definition of a standard.

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

If you have Invariant Sections, Front-Cover Texts and Back-Cover Texts, replace the "with … Texts." line with this:

with the Invariant Sections being LIST THEIR TITLES, with the Front-Cover Texts being LIST, and with the Back-Cover Texts being LIST.
If you have Invariant Sections without Cover Texts, or some other combination of the three, merge those two alternatives to suit the situation.

If your document contains nontrivial examples of program code, we recommend releasing these examples in parallel under your choice of free software license, such as the GNU General Public License, to permit their use in free software.

## Welcome to GitHub Pages

You can use the [editor on GitHub](https://github.com/pedonc/windows-deployment/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/pedonc/windows-deployment/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
