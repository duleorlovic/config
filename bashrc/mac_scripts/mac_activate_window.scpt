FasdUAS 1.101.10   ��   ��    k             i         I     �� 	��
�� .aevtoappnull  �   � **** 	 l      
���� 
 o      ���� 0 keychar keyChar��  ��  ��    k    k       l     ��  ��    6 0 display dialog "mac_activate_window " & keyChar     �   `   d i s p l a y   d i a l o g   " m a c _ a c t i v a t e _ w i n d o w   "   &   k e y C h a r      l     ��  ��      set keyChar to "l"     �   &   s e t   k e y C h a r   t o   " l "      Q     W     O    3    k    2       r    
   !   m     " " � # # L ~ / c o n f i g / b a s h r c / m a c _ s c r i p t s / d a t a . p l i s t ! o      ���� 20 thepropertylistfilepath thePropertyListFilePath   $ % $ r     & ' & b     ( ) ( m     * * � + +  w i n d o w I d - ) o    ���� 0 keychar keyChar ' o      ���� 0 keyid keyId %  , - , r     . / . b     0 1 0 m     2 2 � 3 3  w i n d o w N a m e - 1 o    ���� 0 keychar keyChar / o      ���� 0 keyname keyName -  4 5 4 O    0 6 7 6 k    / 8 8  9 : 9 r    & ; < ; l   $ =���� = n    $ > ? > 1   " $��
�� 
valL ? 4    "�� @
�� 
plii @ o     !���� 0 keyid keyId��  ��   < o      ���� 0 windowid windowId :  A�� A r   ' / B C B l  ' - D���� D n   ' - E F E 1   + -��
�� 
valL F 4   ' +�� G
�� 
plii G o   ) *���� 0 keyname keyName��  ��   C o      ���� 0 
windowname 
windowName��   7 4    �� H
�� 
plif H o    ���� 20 thepropertylistfilepath thePropertyListFilePath 5  I J I l  1 1�� K L��   K #  display dialog "keystroke 1"    L � M M :   d i s p l a y   d i a l o g   " k e y s t r o k e   1 " J  N�� N l  1 1�� O P��   O 7 1 keystroke "1" using {control down, command down}    P � Q Q b   k e y s t r o k e   " 1 "   u s i n g   { c o n t r o l   d o w n ,   c o m m a n d   d o w n }��    m     R R�                                                                                  sevs  alis    \  Macintosh HD               �!��BD ����System Events.app                                              �����!��        ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��    R      �� S��
�� .ascrerr ****      � **** S o      ���� 0 errmsg errMsg��    k   ; W T T  U V U I  ; L�� W��
�� .sysodlogaskr        TEXT W b   ; H X Y X b   ; D Z [ Z b   ; B \ ] \ b   ; @ ^ _ ^ b   ; > ` a ` o   ; <���� 0 errmsg errMsg a m   < = b b � c c V   P l e a s e   c r e a t e   w i n d o w   s h o r t c u t   f o r   k e y C h a r   _ o   > ?���� 0 keychar keyChar ] m   @ A d d � e e &   w i t h   a :   ' b '   o r   ' b   [ o   B C���� 0 keychar keyChar Y m   D G f f � g g  '��   V  h�� h R   M W���� i
�� .ascrerr ****      � ****��   i �� j��
�� 
errn j m   Q T��������  ��     k l k Z   X | m n���� m =  X a o p o l  X ] q���� q c   X ] r s r o   X Y���� 0 windowid windowId s m   Y \��
�� 
TEXT��  ��   p m   ] ` t t � u u   n k   d x v v  w x w I  d m�� y��
�� .sysodlogaskr        TEXT y b   d i z { z m   d g | | � } } F P l e a s e   d e f i n e   w i n d o w I d   f o r   k e y C h a r   { o   g h���� 0 keychar keyChar��   x  ~�� ~ R   n x���� 
�� .ascrerr ****      � ****��    �� ���
�� 
errn � m   r u��������  ��  ��  ��   l  � � � l  } }�� � ���   � K E display dialog " windowId=" & windowId & " windowName=" & windowName    � � � � �   d i s p l a y   d i a l o g   "   w i n d o w I d = "   &   w i n d o w I d   &   "   w i n d o w N a m e = "   &   w i n d o w N a m e �  � � � r   } � � � � J   } � � �  � � � m   } � � � � � �  G o o g l e   C h r o m e �  � � � m   � � � � � � � 
 B r a v e �  � � � m   � � � � � � �  C h a t G P T �  ��� � m   � � � � � � �  d a t e��   � o      ���� 0 mylist myList �  � � � l  � ���������  ��  ��   �  � � � r   � � � � � m   � ���
�� boovfals � o      ����  0 containsstring containsString �  � � � l  � ���������  ��  ��   �  � � � X   � � ��� � � Z   � � � ����� � =  � � � � � l  � � ����� � c   � � � � � o   � ����� 0 currentitem currentItem � m   � ���
�� 
ctxt��  ��   � o   � ����� 0 
windowname 
windowName � k   � � � �  � � � r   � � � � � m   � ���
�� boovtrue � o      ����  0 containsstring containsString �  ��� �  S   � ���  ��  ��  �� 0 currentitem currentItem � o   � ����� 0 mylist myList �  � � � l  � ���������  ��  ��   �  � � � Z   �i � ��� � � o   � �����  0 containsstring containsString � k   � � � �  � � � l  � ��� � ���   � W Q display dialog " containsString " & containsString & " windowName " & windowName    � � � � �   d i s p l a y   d i a l o g   "   c o n t a i n s S t r i n g   "   &   c o n t a i n s S t r i n g   &   "   w i n d o w N a m e   "   &   w i n d o w N a m e �  � � � l  � ��� � ���   � w q it is ok al long we have only one active window in both desktops since it will just open the last visible window    � � � � �   i t   i s   o k   a l   l o n g   w e   h a v e   o n l y   o n e   a c t i v e   w i n d o w   i n   b o t h   d e s k t o p s   s i n c e   i t   w i l l   j u s t   o p e n   t h e   l a s t   v i s i b l e   w i n d o w �  � � � l  � ��� � ���   � : 4 firefox has a problem to disable it's own shortcuts    � � � � h   f i r e f o x   h a s   a   p r o b l e m   t o   d i s a b l e   i t ' s   o w n   s h o r t c u t s �  � � � l  � ���������  ��  ��   �  ��� � O  � � � � � I  � �������
�� .miscactvnull��� ��� null��  ��   � 4   � ��� �
�� 
capp � o   � ����� 0 
windowname 
windowName��  ��   � k   �i � �  � � � l  � ���������  ��  ��   �  � � � O   �g � � � k   �f � �  � � � l  � ��� � ���   � t n when we activate before changing the index than last opened window will also popsup and it might overlap some    � � � � �   w h e n   w e   a c t i v a t e   b e f o r e   c h a n g i n g   t h e   i n d e x   t h a n   l a s t   o p e n e d   w i n d o w   w i l l   a l s o   p o p s u p   a n d   i t   m i g h t   o v e r l a p   s o m e �  � � � l  � ��� � ���   � { u window but if we activate at the end, than when terminals are in separate desktops, it will show last opened window     � � � � �   w i n d o w   b u t   i f   w e   a c t i v a t e   a t   t h e   e n d ,   t h a n   w h e n   t e r m i n a l s   a r e   i n   s e p a r a t e   d e s k t o p s ,   i t   w i l l   s h o w   l a s t   o p e n e d   w i n d o w   �  � � � l  � ��� � ���   � !  instead of target windowId    � � � � 6   i n s t e a d   o f   t a r g e t   w i n d o w I d �  � � � I  � �������
�� .miscactvnull��� ��� null��  ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �   get id of every window    � � � � .   g e t   i d   o f   e v e r y   w i n d o w �  � � � r   �
 � � � 6  � � � � n   � � � � � 1   � ���
�� 
ID   � 2   � ���
�� 
cwin � =  � � � � 1   ���
�� 
pvis � m  ��
�� boovtrue � o      ���� 0 	windowids 	windowIds �  � � � l �� � ���   �   display dialog windowIds    � � � � 2   d i s p l a y   d i a l o g   w i n d o w I d s �  �  � Y  d���� k  _  r  * n  &	
	 4   &��
�� 
cobj 1  #%��
�� 
pidx
 l  ���� 2   ��
�� 
cwin��  ��   o      ���� 0 
wreference 
wReference  Z  +]��� = +: n  +4 4  .4�~
�~ 
cobj 1  13�}
�} 
pidx o  +.�|�| 0 	windowids 	windowIds c  49 o  45�{�{ 0 windowid windowId m  58�z
�z 
long k  =Y  l ==�y�y   &  tell application "System Events"    � @ t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "  l ==�x !�x    5 /	key code 40 using {control down, command down}   ! �"" ^ 	 k e y   c o d e   4 0   u s i n g   { c o n t r o l   d o w n ,   c o m m a n d   d o w n } #$# l ==�w%&�w  %  end tell   & �''  e n d   t e l l$ ()( l ==�v�u�t�v  �u  �t  ) *+* l ==�s,-�s  ,    display dialog wReference   - �.. 4   d i s p l a y   d i a l o g   w R e f e r e n c e+ /0/ l ==�r�q�p�r  �q  �p  0 121 l ==�o34�o  3 + % set the index of the wReference to 1   4 �55 J   s e t   t h e   i n d e x   o f   t h e   w R e f e r e n c e   t o   12 676 l ==�n89�n  8 %  set index of front window to 2   9 �:: >   s e t   i n d e x   o f   f r o n t   w i n d o w   t o   27 ;<; l ==�m=>�m  =   delay 0.05   > �??    d e l a y   0 . 0 5< @A@ l ==�lBC�l  B 5 / do shell script "open -a '" & windowName & "'"   C �DD ^   d o   s h e l l   s c r i p t   " o p e n   - a   ' "   &   w i n d o w N a m e   &   " ' "A EFE l ==�kGH�k  G + % set the index of the wReference to 1   H �II J   s e t   t h e   i n d e x   o f   t h e   w R e f e r e n c e   t o   1F JKJ l ==�j�i�h�j  �i  �h  K LML O  =WNON k  CVPP QRQ r  CFSTS m  CD�g�g T 1      �f
�f 
pidxR UVU l GG�eWX�e  W G A witout those lines it will not jump from one terminal to another   X �YY �   w i t o u t   t h o s e   l i n e s   i t   w i l l   n o t   j u m p   f r o m   o n e   t e r m i n a l   t o   a n o t h e rV Z[Z l GG�d\]�d  \ 2 , and this is causing small flickering effect   ] �^^ X   a n d   t h i s   i s   c a u s i n g   s m a l l   f l i c k e r i n g   e f f e c t[ _`_ l GG�cab�c  a M G sometimes it does not show correct window but the last opened terminal   b �cc �   s o m e t i m e s   i t   d o e s   n o t   s h o w   c o r r e c t   w i n d o w   b u t   t h e   l a s t   o p e n e d   t e r m i n a l` ded r  GNfgf m  GH�b
�b boovfalsg 1  HM�a
�a 
pvise h�`h r  OViji m  OP�_
�_ boovtruej 1  PU�^
�^ 
pvis�`  O o  =@�]�] 0 
wreference 
wReferenceM klk l XX�\�[�Z�\  �[  �Z  l mnm l XX�Yop�Y  o @ : activate -- this will open all windows of the application   p �qq t   a c t i v a t e   - -   t h i s   w i l l   o p e n   a l l   w i n d o w s   o f   t h e   a p p l i c a t i o nn rsr l XX�Xtu�X  t 9 3 activate wReference -- also open whole app windows   u �vv f   a c t i v a t e   w R e f e r e n c e   - -   a l s o   o p e n   w h o l e   a p p   w i n d o w ss wxw l XX�Wyz�W  y l f tell application "System Events" to tell process windowName to perform action "AXRaise" of wReference   z �{{ �   t e l l   a p p l i c a t i o n   " S y s t e m   E v e n t s "   t o   t e l l   p r o c e s s   w i n d o w N a m e   t o   p e r f o r m   a c t i o n   " A X R a i s e "   o f   w R e f e r e n c ex |}| l XX�V�U�T�V  �U  �T  } ~~ l XX�S���S  � ' !set wName to name of front window   � ��� B s e t   w N a m e   t o   n a m e   o f   f r o n t   w i n d o w ��� l XX�R���R  �  display dialog wName   � ��� ( d i s p l a y   d i a l o g   w N a m e� ��� l XX�Q���Q  �   select wReference   � ��� $   s e l e c t   w R e f e r e n c e� ��P� l XX�O�N�M�O  �N  �M  �P  ��  �   ��L� l ^^�K�J�I�K  �J  �I  �L  
�� 
pidx m  �H�H  I �G��F
�G .corecnte****       ****� o  �E�E 0 	windowids 	windowIds�F  ��    ��� l ee�D�C�B�D  �C  �B  � ��� l ee�A���A  �  	 activate   � ���    a c t i v a t e� ��@� l ee�?���?  �   display dialog windowId   � ��� 0   d i s p l a y   d i a l o g   w i n d o w I d�@   � 4   � ��>�
�> 
capp� o   � ��=�= 0 
windowname 
windowName � ��<� l hh�;�:�9�;  �:  �9  �<   � ��8� l jj�7�6�5�7  �6  �5  �8    ��4� l     �3�2�1�3  �2  �1  �4       �0���0  � �/
�/ .aevtoappnull  �   � ****� �. �-�,���+
�. .aevtoappnull  �   � ****�- 0 keychar keyChar�,  � �*�)�(�'�* 0 keychar keyChar�) 0 errmsg errMsg�( 0 currentitem currentItem
�' 
pidx� + R "�& *�% 2�$�#�"�!� ��� b d f���� t | � � � �����������������
�& 20 thepropertylistfilepath thePropertyListFilePath�% 0 keyid keyId�$ 0 keyname keyName
�# 
plif
�" 
plii
�! 
valL�  0 windowid windowId� 0 
windowname 
windowName� 0 errmsg errMsg�  
� .sysodlogaskr        TEXT
� 
errn���
� 
TEXT� � 0 mylist myList�  0 containsstring containsString
� 
kocl
� 
cobj
� .corecnte****       ****
� 
ctxt
� 
capp
� .miscactvnull��� ��� null
� 
cwin
� 
ID  �  
� 
pvis� 0 	windowids 	windowIds� 0 
wreference 
wReference
�
 
long�+l 5� -�E�O�%E�O�%E�O*��/ *��/�,E�O*��/�,E�UOPUW #X  ��%�%�%�%a %j O)a a lhO�a &a   a �%j O)a a lhY hOa a a a a vE` OfE` O /_ [a a l  kh �a !&�  eE` OY h[OY��O_  *a "�/ *j #UY �*a "�/ ~*j #O*a $-a %,a &[a ',\Ze81E` (O Xk_ (j  kh *a $-a �E/E` )O_ (a �E/�a *&  !_ ) kE�Of*a ',FOe*a ',FUOPY hOP[OY��OPUOPOP ascr  ��ޭ