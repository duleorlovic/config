FasdUAS 1.101.10   ��   ��    l      ����  i         I     �� ��
�� .aevtoappnull  �   � ****  l      ����  o      ���� 0 command_string  ��  ��  ��    k    � 	 	  
  
 l     ��  ��    #  set command_string to "date"     �   :   s e t   c o m m a n d _ s t r i n g   t o   " d a t e "      l     ��  ��    $  display dialog command_string     �   <   d i s p l a y   d i a l o g   c o m m a n d _ s t r i n g      l     ��������  ��  ��        l     ��  ��    "  STEP 1: Find Current window     �   8   S T E P   1 :   F i n d   C u r r e n t   w i n d o w      r         m        �     
 s l a s h  o      ���� 0 key_name     ! " ! O     # $ # r     % & % 6    ' ( ' n     ) * ) 1    ��
�� 
pnam * 4   �� +
�� 
pcap + m   
 ����  ( =    , - , 1    ��
�� 
pisf - m    ��
�� boovtrue & o      ���� 0 frontapp frontApp $ m     . .�                                                                                  sevs  alis    \  Macintosh HD                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   "  / 0 / O    1 1 2 1 k   " 0 3 3  4 5 4 r   " * 6 7 6 n   " ( 8 9 8 1   & (��
�� 
ID   9 4  " &�� :
�� 
cwin : m   $ %����  7 o      ���� "0 currentwindowid currentWindowId 5  ;�� ; r   + 0 < = < 1   + .��
�� 
pnam = o      ���� &0 currentwindowname currentWindowName��   2 4    �� >
�� 
capp > o    ���� 0 frontapp frontApp 0  ? @ ? l  2 2��������  ��  ��   @  A B A l  2 2�� C D��   C &   STEP 2: Determine Target window    D � E E @   S T E P   2 :   D e t e r m i n e   T a r g e t   w i n d o w B  F G F Q   2 � H I J H O   5 { K L K k   9 z M M  N O N r   9 < P Q P m   9 : R R � S S L ~ / c o n f i g / b a s h r c / m a c _ s c r i p t s / d a t a . p l i s t Q o      ���� 20 thepropertylistfilepath thePropertyListFilePath O  T U T r   = D V W V b   = @ X Y X m   = > Z Z � [ [  w i n d o w I d - Y o   > ?���� 0 key_name   W o      ���� 0 
key_nameid 
key_nameId U  \ ] \ r   E N ^ _ ^ b   E J ` a ` m   E H b b � c c  w i n d o w N a m e - a o   H I���� 0 key_name   _ o      ���� 0 key_namename key_nameName ]  d�� d O   O z e f e k   X y g g  h i h r   X h j k j l  X d l���� l n   X d m n m 1   ` d��
�� 
valL n 4   X `�� o
�� 
plii o o   \ _���� 0 
key_nameid 
key_nameId��  ��   k o      ���� 0 windowid windowId i  p�� p r   i y q r q l  i u s���� s n   i u t u t 1   q u��
�� 
valL u 4   i q�� v
�� 
plii v o   m p���� 0 key_namename key_nameName��  ��   r o      ���� 0 
windowname 
windowName��   f 4   O U�� w
�� 
plif w o   S T���� 20 thepropertylistfilepath thePropertyListFilePath��   L m   5 6 x x�                                                                                  sevs  alis    \  Macintosh HD                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   I R      �� y��
�� .ascrerr ****      � **** y o      ���� 0 errmsg errMsg��   J k   � � z z  { | { I  � ��� }��
�� .sysodlogaskr        TEXT } b   � � ~  ~ b   � � � � � b   � � � � � b   � � � � � b   � � � � � o   � ����� 0 errmsg errMsg � m   � � � � � � � X   P l e a s e   c r e a t e   w i n d o w   s h o r t c u t   f o r   k e y _ n a m e   � o   � ����� 0 key_name   � m   � � � � � � � &   w i t h   a :   ' b '   o r   ' b   � o   � ����� 0 key_name    m   � � � � � � �  '��   |  ��� � R   � ����� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � m   � ���������  ��   G  � � � Z   � � � ����� � =  � � � � � l  � � ����� � c   � � � � � o   � ����� 0 windowid windowId � m   � ���
�� 
TEXT��  ��   � m   � � � � � � �   � k   � � � �  � � � I  � ��� ���
�� .sysodlogaskr        TEXT � b   � � � � � m   � � � � � � � H P l e a s e   d e f i n e   w i n d o w I d   f o r   k e y _ n a m e   � o   � ����� 0 key_name  ��   �  ��� � R   � ����� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � m   � ���������  ��  ��  ��   �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � - ' STEP 3: Send commands to Target window    � � � � N   S T E P   3 :   S e n d   c o m m a n d s   t o   T a r g e t   w i n d o w �  � � � O   �\ � � � k   �[ � �  � � � I  � �������
�� .miscactvnull��� ��� null��  ��   �  � � � r   � � � � � 6  � � � � � n   � � � � � 1   � ���
�� 
ID   � 2   � ���
�� 
cwin � =  � � � � � 1   � ���
�� 
pvis � m   � ���
�� boovtrue � o      ���� 0 	windowids 	windowIds �  � � � l  � ��� � ���   �   display dialog windowIds    � � � � 2   d i s p l a y   d i a l o g   w i n d o w I d s �  � � � Y   �Y ��� � ��� � k   �T � �  � � � r   � � � � n   � � � � 4  �� �
�� 
cobj � 1  ��
�� 
pidx � l  � ����� � 2   ���
�� 
cwin��  ��   � o      ���� 0 
wreference 
wReference �  ��� � Z  T � ����� � =  � � � n   � � � 4  �� �
�� 
cobj � 1  ��
�� 
pidx � o  ���� 0 	windowids 	windowIds � c   � � � o  ���� 0 windowid windowId � m  ��
�� 
long � k  !P � �  � � � O  !N � � � k  'M � �  � � � r  '* � � � m  '(����  � 1      ��
�� 
pidx �  � � � r  +2 � � � m  +,��
�� boovfals � 1  ,1��
�� 
pvis �  � � � r  3: � � � m  34��
�� boovtrue � 1  49��
�� 
pvis �  � � � l ;;��������  ��  ��   �  ��� � O  ;M � � � k  ?L � �  � � � I ?D�� ���
�� .prcskprsnull���     ctxt � o  ?@���� 0 command_string  ��   �  ��� � I EL�� ��
�� .prcskprsnull���     ctxt � o  EH�~
�~ 
ret �  ��   � m  ;< � ��                                                                                  sevs  alis    \  Macintosh HD                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��   � o  !$�}�} 0 
wreference 
wReference �  � � � l OO�|�{�z�|  �{  �z   �  � � � l OO�y � ��y   � ' !set wName to name of front window    � �   B s e t   w N a m e   t o   n a m e   o f   f r o n t   w i n d o w �  l OO�x�x    display dialog wName    � ( d i s p l a y   d i a l o g   w N a m e  l OO�w	�w     select wReference   	 �

 $   s e l e c t   w R e f e r e n c e �v l OO�u�t�s�u  �t  �s  �v  ��  ��  ��  
�� 
pidx � m   � ��r�r  � I  � ��q�p
�q .corecnte****       **** o   � ��o�o 0 	windowids 	windowIds�p  ��   �  l ZZ�n�m�l�n  �m  �l    l ZZ�k�k    	 activate    �    a c t i v a t e  l ZZ�j�j     display dialog windowId    � 0   d i s p l a y   d i a l o g   w i n d o w I d �i l ZZ�h�g�f�h  �g  �f  �i   � 4   � ��e
�e 
capp o   � ��d�d 0 
windowname 
windowName �  l ]]�c�b�a�c  �b  �a    l ]]�` �`   &   STEP 4: Activate current window     �!! @   S T E P   4 :   A c t i v a t e   c u r r e n t   w i n d o w "�_" O  ]�#$# k  d�%% &'& I di�^�]�\
�^ .miscactvnull��� ��� null�]  �\  ' ()( r  j~*+* 6 jz,-, n  jo./. 1  mo�[
�[ 
ID  / 2  jm�Z
�Z 
cwin- = py010 1  qu�Y
�Y 
pvis1 m  vx�X
�X boovtrue+ o      �W�W 0 	windowids 	windowIds) 232 l �V45�V  4   display dialog windowIds   5 �66 2   d i s p l a y   d i a l o g   w i n d o w I d s3 7�U7 Y  �8�T9:�S8 k  ��;; <=< r  ��>?> n  ��@A@ 4  ���RB
�R 
cobjB 1  ���Q
�Q 
pidxA l ��C�P�OC 2  ���N
�N 
cwin�P  �O  ? o      �M�M 0 
wreference 
wReference= D�LD Z  ��EF�K�JE = ��GHG n  ��IJI 4  ���IK
�I 
cobjK 1  ���H
�H 
pidxJ o  ���G�G 0 	windowids 	windowIdsH c  ��LML o  ���F�F "0 currentwindowid currentWindowIdM m  ���E
�E 
longF O  ��NON k  ��PP QRQ r  ��STS m  ���D�D T 1      �C
�C 
pidxR UVU r  ��WXW m  ���B
�B boovfalsX 1  ���A
�A 
pvisV Y�@Y r  ��Z[Z m  ���?
�? boovtrue[ 1  ���>
�> 
pvis�@  O o  ���=�= 0 
wreference 
wReference�K  �J  �L  
�T 
pidx9 m  ���<�< : I ���;\�:
�; .corecnte****       ****\ o  ���9�9 0 	windowids 	windowIds�:  �S  �U  $ 4  ]a�8]
�8 
capp] o  _`�7�7 &0 currentwindowname currentWindowName�_  ��  ��       �6^_ `�5a Rbc�4def�3�2�1�0�6  ^ �/�.�-�,�+�*�)�(�'�&�%�$�#�"�!� 
�/ .aevtoappnull  �   � ****�. 0 key_name  �- 0 frontapp frontApp�, "0 currentwindowid currentWindowId�+ &0 currentwindowname currentWindowName�* 20 thepropertylistfilepath thePropertyListFilePath�) 0 
key_nameid 
key_nameId�( 0 key_namename key_nameName�' 0 windowid windowId�& 0 
windowname 
windowName�% 0 	windowids 	windowIds�$ 0 
wreference 
wReference�#  �"  �!  �   _ � ��gh�
� .aevtoappnull  �   � ****� 0 command_string  �  g ���� 0 command_string  � 0 errmsg errMsg
� 
pidxh , � .��i������� R� Z� b���
�	���� � � ����� � �� ����������������� 0 key_name  
� 
pcap
� 
pnami  
� 
pisf� 0 frontapp frontApp
� 
capp
� 
cwin
� 
ID  � "0 currentwindowid currentWindowId� &0 currentwindowname currentWindowName� 20 thepropertylistfilepath thePropertyListFilePath� 0 
key_nameid 
key_nameId� 0 key_namename key_nameName
� 
plif
�
 
plii
�	 
valL� 0 windowid windowId� 0 
windowname 
windowName� 0 errmsg errMsg�  
� .sysodlogaskr        TEXT
� 
errn���
� 
TEXT
�  .miscactvnull��� ��� null
�� 
pvis�� 0 	windowids 	windowIds
�� .corecnte****       ****
�� 
cobj�� 0 
wreference 
wReference
�� 
long
�� .prcskprsnull���     ctxt
�� 
ret ���E�O� *�k/�,�[�,\Ze81E�UO*��/ *�k/�,E�O*�,E�UO K� C�E�O��%E` Oa �%E` O*a �/ #*a _ /a ,E` O*a _ /a ,E` UUW 'X  �a %�%a %�%a %j O)a a lhO_ a  &a !  a "�%j O)a a lhY hO*�_ / �*j #O*�-�,�[a $,\Ze81E` %O ik_ %j &kh *�-a '�E/E` (O_ %a '�E/_ a )&  4_ ( (kE�Of*a $,FOe*a $,FO� �j *O_ +j *UUOPY h[OY��OPUO*��/ p*j #O*�-�,�[a $,\Ze81E` %O Rk_ %j &kh *�-a '�E/E` (O_ %a '�E/�a )&  _ ( kE�Of*a $,FOe*a $,FUY h[OY��U` �jj  T e r m i n a l�5(a �kk  T e r m i n a lb �ll  w i n d o w I d - s l a s hc �mm   w i n d o w N a m e - s l a s h�4 /d �nn  T e r m i n a le ��o�� o  ��������(����&f pp q������q�                                                                                      @ alis    J  Macintosh HD                   BD ����Terminal.app                                                   ����            ����  
 cu             	Utilities   -/:System:Applications:Utilities:Terminal.app/     T e r m i n a l . a p p    M a c i n t o s h   H D  *System/Applications/Utilities/Terminal.app  / ��  
�� 
cwin��&
�� kfrmID  �3  �2  �1  �0  ascr  ��ޭ