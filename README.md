2022/5/13:
DQ_COMMON_RC中发射可以做最后版本,没什么问题，该版本最后checksum:06A381

现在在这个版本发射的基础上053D改为053E 
new checksum:5E3AC1 C_MODE_RX_En=0 C_DK071=0

接收看了下新版本改动，是加上了定时慢慢减小，以前版本很可能没有PWM慢慢减小的功能。
新烧的版本 就用DK071 DK071 有PWM慢慢减小的功能，而DK068没有

 new version DK071CheckSum: 098DF0   C_MODE_RX_En=1 C_DK071=1


2021/11/10:

接收断电连不上发射机？ 接收玩的时间不够？


2021/10/28:
  25min start slow 
  25s slow->1% speed
  min slow speed is 5/16?


2021/10/21:
  new add function

  if work over time (25min?)

  enter slow mode 启动后，从当前速度慢慢减速到10%

  工作的时候开始计时，停止的时候不计时，累计计时25min

  4*32 = 128ms?

  1:24 是越野车? DK068?
