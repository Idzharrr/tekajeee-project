#!/bin/bash
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd

cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SecurePay — Coming Soon</title>
<link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,300;12..96,500;12..96,700;12..96,800&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
:root{--a:#5B7EC9;--ad:#3F5FA8;--al:#E6ECF8;--ink:#0D1B2A;--ink2:#4A5568;--ink3:#94A3B8;--bg:#ECF0F7;--b:rgba(13,27,42,0.08);--f:'Bricolage Grotesque',sans-serif}
html,body{height:100%;overflow:hidden}
body{background:var(--bg);color:var(--ink);font-family:var(--f);display:flex;flex-direction:column;height:100vh}

/* bg */
.bg-wrap{position:fixed;inset:0;pointer-events:none;z-index:0}
.bg-wrap::before{content:'';position:absolute;top:-200px;right:-200px;width:560px;height:560px;border-radius:50%;background:radial-gradient(circle,rgba(91,126,201,.12),transparent 70%)}
.bg-wrap::after{content:'';position:absolute;bottom:-200px;left:-200px;width:500px;height:500px;border-radius:50%;background:radial-gradient(circle,rgba(212,146,10,.08),transparent 70%)}
.bg-dots{position:fixed;inset:0;pointer-events:none;z-index:0;background-image:radial-gradient(circle,rgba(91,126,201,.13) 1px,transparent 1px);background-size:30px 30px;mask-image:radial-gradient(ellipse 65% 55% at 50% 50%,black 20%,transparent 100%);-webkit-mask-image:radial-gradient(ellipse 65% 55% at 50% 50%,black 20%,transparent 100%)}

/* side panels — right is CSS mirror of left */
.sd{position:fixed;top:0;bottom:0;width:360px;z-index:1;pointer-events:none;overflow:hidden}
.sd.l{left:0}
.sd.r{right:0;transform:scaleX(-1)}
.sd svg{position:absolute;top:0;left:0;width:100%;height:100%}

/* svg animations */
.dp{stroke-dasharray:1200;stroke-dashoffset:1200;animation:draw 3s ease forwards}
.dp2{animation-delay:.4s}.dp3{animation-delay:.8s}.dp4{animation-delay:1.2s}
.df{opacity:0;animation:fade .8s ease forwards}
.df2{animation-delay:.8s}.df3{animation-delay:1.4s}.df4{animation-delay:2s}
.dn{animation:pulse 3s ease-in-out infinite}
.dn2{animation-delay:.8s}.dn3{animation-delay:1.6s}
@keyframes draw{to{stroke-dashoffset:0}}
@keyframes fade{to{opacity:1}}
@keyframes pulse{0%,100%{opacity:.3}50%{opacity:.8}}

/* ticker */
.tick{background:var(--a);overflow:hidden;flex-shrink:0;height:34px;line-height:34px;white-space:nowrap;position:relative;z-index:2}
.tick-inner{display:inline-block;animation:ticker 40s linear infinite}
.ti{display:inline;font-size:10px;font-weight:600;letter-spacing:2px;text-transform:uppercase;color:rgba(255,255,255,.82);padding:0 20px}
.ts{display:inline;color:rgba(255,255,255,.3);font-size:10px}
@keyframes ticker{from{transform:translateX(0)}to{transform:translateX(-50%)}}

/* nav */
nav{display:flex;align-items:center;justify-content:space-between;padding:14px 48px;border-bottom:1px solid var(--b);background:rgba(236,240,247,.9);backdrop-filter:blur(10px);flex-shrink:0;position:relative;z-index:2;animation:fadeDown .5s ease both}
.logo{display:flex;align-items:center;gap:10px;text-decoration:none}
.lm{width:36px;height:36px;border-radius:10px;background:linear-gradient(140deg,var(--a),var(--ad));display:flex;align-items:center;justify-content:center;box-shadow:0 2px 10px rgba(91,126,201,.32),inset 0 1px 0 rgba(255,255,255,.15);position:relative;overflow:hidden}
.lm::before{content:'';position:absolute;top:0;left:0;right:0;height:45%;background:rgba(255,255,255,.1)}
.lm svg{width:19px;height:19px;fill:#fff;position:relative;z-index:1}
.lt{font-size:16px;font-weight:700;color:var(--ink);letter-spacing:-.3px}
.lt em{font-style:normal;color:var(--a)}
.nb{display:flex;align-items:center;gap:6px;background:var(--al);color:var(--a);font-size:10px;font-weight:700;letter-spacing:1px;text-transform:uppercase;padding:5px 13px;border-radius:100px;border:1px solid rgba(91,126,201,.18)}
.ld{width:6px;height:6px;border-radius:50%;background:var(--a);animation:blinkB 1.8s ease infinite}
@keyframes blinkB{0%,100%{box-shadow:0 0 0 0 rgba(91,126,201,.55)}50%{box-shadow:0 0 0 5px rgba(91,126,201,0)}}

/* hero */
.hero{flex:1;min-height:0;display:flex;align-items:center;justify-content:center;padding:24px;position:relative;z-index:2;animation:fadeUp .6s .1s ease both}
.hi{display:flex;flex-direction:column;align-items:center;text-align:center;max-width:560px;width:100%}

/* badge */
.bw{position:relative;margin-bottom:20px;display:inline-block}
.bw::before{content:'';position:absolute;inset:-6px;border-radius:100px;background:rgba(91,126,201,.12);animation:glow 2s ease infinite}
.bw::after{content:'';position:absolute;inset:-12px;border-radius:100px;background:rgba(91,126,201,.06);animation:glow 2s .3s ease infinite}
@keyframes glow{0%,100%{opacity:1;transform:scale(1)}50%{opacity:.4;transform:scale(1.04)}}
.bl{display:inline-flex;align-items:center;gap:12px;background:linear-gradient(135deg,var(--a),var(--ad));color:#fff;font-size:15px;font-weight:800;letter-spacing:4px;text-transform:uppercase;padding:14px 32px;border-radius:100px;box-shadow:0 8px 32px rgba(91,126,201,.38),0 2px 8px rgba(91,126,201,.22),inset 0 1px 0 rgba(255,255,255,.2);animation:popIn .6s .2s cubic-bezier(.34,1.56,.64,1) both;position:relative;overflow:hidden}
.bl::before{content:'';position:absolute;top:0;left:-100%;width:60%;height:100%;background:linear-gradient(90deg,transparent,rgba(255,255,255,.15),transparent);animation:shine 2.8s 1.2s ease infinite}
@keyframes shine{0%,100%{left:140%}0%{left:-100%}40%{left:140%}}
.bld{width:9px;height:9px;border-radius:50%;background:rgba(255,255,255,.9);flex-shrink:0;animation:blinkW 1.6s ease infinite}
@keyframes blinkW{0%,100%{box-shadow:0 0 0 0 rgba(255,255,255,.5);opacity:.9}50%{box-shadow:0 0 0 4px rgba(255,255,255,0);opacity:1}}
@keyframes popIn{from{opacity:0;transform:scale(.8) translateY(12px)}to{opacity:1;transform:scale(1) translateY(0)}}

/* heading */
h1{font-size:clamp(40px,5.6vw,72px);font-weight:800;line-height:1.06;letter-spacing:-2.5px;margin-bottom:12px}
h1 .ld2{display:block;color:var(--ink)}
h1 .la{display:block;color:var(--a)}
.hd{font-size:14px;font-weight:300;color:var(--ink2);line-height:1.6;max-width:400px;margin-bottom:20px}

/* pills */
.pr{display:flex;flex-wrap:wrap;justify-content:center;gap:8px}
.pill{display:inline-flex;align-items:center;gap:7px;background:#fff;color:var(--ink);border:1px solid var(--b);border-radius:100px;padding:8px 16px;font-size:12px;font-weight:500;box-shadow:0 1px 4px rgba(13,27,42,.06);transition:all .2s}
.pill:hover{background:var(--al);border-color:var(--a);color:var(--a)}
.pill svg{width:13px;height:13px;flex-shrink:0}

/* footer */
.foot{border-top:1px solid var(--b);display:flex;align-items:center;justify-content:space-between;padding:11px 48px;flex-shrink:0;background:rgba(236,240,247,.7);position:relative;z-index:2;animation:fadeUp .5s .4s ease both}
.foot-copy{font-size:11px;color:var(--ink3)}
.fl{display:flex;gap:16px}
.fla{font-size:11px;color:var(--ink3);text-decoration:none;transition:color .2s}
.fla:hover{color:var(--a)}

@keyframes fadeUp{from{opacity:0;transform:translateY(16px)}to{opacity:1;transform:none}}
@keyframes fadeDown{from{opacity:0;transform:translateY(-10px)}to{opacity:1;transform:none}}

/* hide side panels on narrow screens */
@media (max-width: 900px){
  .sd{display:none}
}
</style>
</head>
<body>
<div class="bg-wrap"></div>
<div class="bg-dots"></div>

<!-- Left panel (right is CSS mirror) -->
<div class="sd l">
  <svg viewBox="0 0 260 900" fill="none" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice">
    <defs>
      <linearGradient id="pg" x1="0" y1="0" x2="1" y2="0">
        <stop offset="0%" stop-color="#C8D7F0"/>
        <stop offset="65%" stop-color="#D8E4F4" stop-opacity=".5"/>
        <stop offset="100%" stop-color="#ECF0F7" stop-opacity="0"/>
      </linearGradient>
      <linearGradient id="f1" x1="0" y1="0" x2="0" y2="1">
        <stop offset="0%" stop-color="#5B7EC9" stop-opacity="0"/>
        <stop offset="45%" stop-color="#5B7EC9" stop-opacity=".42"/>
        <stop offset="100%" stop-color="#5B7EC9" stop-opacity=".08"/>
      </linearGradient>
      <linearGradient id="f2" x1="0" y1="0" x2="0" y2="1">
        <stop offset="0%" stop-color="#5B7EC9" stop-opacity="0"/>
        <stop offset="50%" stop-color="#5B7EC9" stop-opacity=".28"/>
        <stop offset="100%" stop-color="#5B7EC9" stop-opacity=".05"/>
      </linearGradient>
      <mask id="wm">
        <path d="M0 0 L200 0 C260 0 260 80 230 160 C200 240 250 320 240 450 C230 580 260 660 240 780 C220 880 200 900 160 900 L0 900Z" fill="white"/>
      </mask>
    </defs>

    <rect width="260" height="900" fill="url(#pg)" mask="url(#wm)"/>

    <!-- flow lines -->
    <path class="dp" d="M55 120 C90 140,140 180,170 220" stroke="#5B7EC9" stroke-opacity=".2" stroke-width="1" stroke-dasharray="4 5" stroke-linecap="round"/>
    <path class="dp dp2" d="M55 120 C20 200,10 300,35 390" stroke="url(#f1)" stroke-width="1.4" stroke-linecap="round"/>
    <path class="dp dp2" d="M170 220 C190 300,180 400,155 500" stroke="#5B7EC9" stroke-opacity=".18" stroke-width="1" stroke-dasharray="3 6" stroke-linecap="round"/>
    <path class="dp dp3" d="M35 390 C60 420,110 460,155 500" stroke="url(#f2)" stroke-width="1.4" stroke-linecap="round"/>
    <path class="dp dp3" d="M155 500 C130 550,80 600,50 660" stroke="url(#f1)" stroke-width="1.6" stroke-linecap="round"/>
    <path class="dp dp4" d="M35 390 C15 480,20 570,50 660" stroke="#5B7EC9" stroke-opacity=".13" stroke-width="1" stroke-dasharray="4 7" stroke-linecap="round"/>
    <path class="dp dp4" d="M50 660 C70 710,120 760,150 810" stroke="url(#f2)" stroke-width="1.4" stroke-linecap="round"/>
    <path id="mp" d="M55 120 C20 200 10 300 35 390 C60 420 110 460 155 500 C130 550 80 600 50 660 C70 710 120 760 150 810" stroke="none"/>

    <!-- nodes A -->
    <circle class="df" cx="55" cy="120" r="20" fill="#5B7EC9" fill-opacity=".06" stroke="#5B7EC9" stroke-opacity=".14" stroke-width="1"/>
    <circle class="df" cx="55" cy="120" r="11" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".24" stroke-width="1"/>
    <circle class="df dn" cx="55" cy="120" r="4.5" fill="#5B7EC9" fill-opacity=".72"/>
    <!-- F -->
    <circle class="df" cx="170" cy="220" r="13" fill="#5B7EC9" fill-opacity=".06" stroke="#5B7EC9" stroke-opacity=".13" stroke-width="1"/>
    <circle class="df dn3" cx="170" cy="220" r="3.5" fill="#5B7EC9" fill-opacity=".58"/>
    <!-- B -->
    <circle class="df df2" cx="35" cy="390" r="15" fill="#5B7EC9" fill-opacity=".06" stroke="#5B7EC9" stroke-opacity=".14" stroke-width="1"/>
    <circle class="df df2" cx="35" cy="390" r="8" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".22" stroke-width="1"/>
    <circle class="df dn2" cx="35" cy="390" r="3.5" fill="#5B7EC9" fill-opacity=".68"/>
    <!-- C -->
    <circle class="df df2" cx="155" cy="500" r="17" fill="#5B7EC9" fill-opacity=".07" stroke="#5B7EC9" stroke-opacity=".15" stroke-width="1"/>
    <circle class="df df2" cx="155" cy="500" r="9" fill="#5B7EC9" fill-opacity=".11" stroke="#5B7EC9" stroke-opacity=".26" stroke-width="1"/>
    <circle class="df dn" cx="155" cy="500" r="4" fill="#5B7EC9" fill-opacity=".72"/>
    <!-- D -->
    <circle class="df df3" cx="50" cy="660" r="20" fill="#5B7EC9" fill-opacity=".06" stroke="#5B7EC9" stroke-opacity=".14" stroke-width="1"/>
    <circle class="df df3" cx="50" cy="660" r="11" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".24" stroke-width="1"/>
    <circle class="df dn3" cx="50" cy="660" r="4.5" fill="#5B7EC9" fill-opacity=".7"/>
    <!-- E -->
    <circle class="df df4" cx="150" cy="810" r="13" fill="#5B7EC9" fill-opacity=".06" stroke="#5B7EC9" stroke-opacity=".13" stroke-width="1"/>
    <circle class="df df4" cx="150" cy="810" r="7" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".21" stroke-width="1"/>
    <circle class="df dn2" cx="150" cy="810" r="3" fill="#5B7EC9" fill-opacity=".62"/>

    <!-- pulse dots -->
    <circle r="2.8" fill="#5B7EC9" fill-opacity=".75"><animateMotion dur="4s" repeatCount="indefinite"><mpath href="#mp"/></animateMotion></circle>
    <circle r="2" fill="#5B7EC9" fill-opacity=".5"><animateMotion dur="4s" repeatCount="indefinite" begin="1.4s"><mpath href="#mp"/></animateMotion></circle>

    <!-- arrow badges -->
    <g class="df df3" transform="translate(178,476)">
      <rect width="22" height="22" rx="5" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".2" stroke-width=".8"/>
      <path d="M4 11L18 11M12 5L18 11L12 17" stroke="#5B7EC9" stroke-opacity=".52" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"/>
    </g>
    <g class="df df4" transform="translate(120,828)">
      <rect width="22" height="22" rx="5" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".17" stroke-width=".8"/>
      <path d="M18 11L4 11M10 5L4 11L10 17" stroke="#5B7EC9" stroke-opacity=".48" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"/>
    </g>
  </svg>
</div>

<!-- Right panel = CSS mirror of left -->
<div class="sd r">
  <svg viewBox="0 0 260 900" fill="none" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice">
    <use href="#pg" xlink:href="#pg"/>
    <rect width="260" height="900" fill="url(#pg)" mask="url(#wm)"/>
    <path class="dp" d="M55 120 C90 140,140 180,170 220" stroke="#5B7EC9" stroke-opacity=".2" stroke-width="1" stroke-dasharray="4 5" stroke-linecap="round"/>
    <path class="dp dp2" d="M55 120 C20 200,10 300,35 390" stroke="url(#f1)" stroke-width="1.4" stroke-linecap="round"/>
    <path class="dp dp2" d="M170 220 C190 300,180 400,155 500" stroke="#5B7EC9" stroke-opacity=".18" stroke-width="1" stroke-dasharray="3 6" stroke-linecap="round"/>
    <path class="dp dp3" d="M35 390 C60 420,110 460,155 500" stroke="url(#f2)" stroke-width="1.4" stroke-linecap="round"/>
    <path class="dp dp3" d="M155 500 C130 550,80 600,50 660" stroke="url(#f1)" stroke-width="1.6" stroke-linecap="round"/>
    <path class="dp dp4" d="M35 390 C15 480,20 570,50 660" stroke="#5B7EC9" stroke-opacity=".13" stroke-width="1" stroke-dasharray="4 7" stroke-linecap="round"/>
    <path class="dp dp4" d="M50 660 C70 710,120 760,150 810" stroke="url(#f2)" stroke-width="1.4" stroke-linecap="round"/>
    <path id="mp2" d="M55 120 C20 200 10 300 35 390 C60 420 110 460 155 500 C130 550 80 600 50 660 C70 710 120 760 150 810" stroke="none"/>
    <circle class="df" cx="55" cy="120" r="20" fill="#5B7EC9" fill-opacity=".06" stroke="#5B7EC9" stroke-opacity=".14" stroke-width="1"/>
    <circle class="df" cx="55" cy="120" r="11" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".24" stroke-width="1"/>
    <circle class="df dn" cx="55" cy="120" r="4.5" fill="#5B7EC9" fill-opacity=".72"/>
    <circle class="df" cx="170" cy="220" r="13" fill="#5B7EC9" fill-opacity=".06" stroke="#5B7EC9" stroke-opacity=".13" stroke-width="1"/>
    <circle class="df dn3" cx="170" cy="220" r="3.5" fill="#5B7EC9" fill-opacity=".58"/>
    <circle class="df df2" cx="35" cy="390" r="15" fill="#5B7EC9" fill-opacity=".06" stroke="#5B7EC9" stroke-opacity=".14" stroke-width="1"/>
    <circle class="df df2" cx="35" cy="390" r="8" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".22" stroke-width="1"/>
    <circle class="df dn2" cx="35" cy="390" r="3.5" fill="#5B7EC9" fill-opacity=".68"/>
    <circle class="df df2" cx="155" cy="500" r="17" fill="#5B7EC9" fill-opacity=".07" stroke="#5B7EC9" stroke-opacity=".15" stroke-width="1"/>
    <circle class="df df2" cx="155" cy="500" r="9" fill="#5B7EC9" fill-opacity=".11" stroke="#5B7EC9" stroke-opacity=".26" stroke-width="1"/>
    <circle class="df dn" cx="155" cy="500" r="4" fill="#5B7EC9" fill-opacity=".72"/>
    <circle class="df df3" cx="50" cy="660" r="20" fill="#5B7EC9" fill-opacity=".06" stroke="#5B7EC9" stroke-opacity=".14" stroke-width="1"/>
    <circle class="df df3" cx="50" cy="660" r="11" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".24" stroke-width="1"/>
    <circle class="df dn3" cx="50" cy="660" r="4.5" fill="#5B7EC9" fill-opacity=".7"/>
    <circle class="df df4" cx="150" cy="810" r="13" fill="#5B7EC9" fill-opacity=".06" stroke="#5B7EC9" stroke-opacity=".13" stroke-width="1"/>
    <circle class="df df4" cx="150" cy="810" r="7" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".21" stroke-width="1"/>
    <circle class="df dn2" cx="150" cy="810" r="3" fill="#5B7EC9" fill-opacity=".62"/>
    <circle r="2.8" fill="#5B7EC9" fill-opacity=".75"><animateMotion dur="4s" repeatCount="indefinite"><mpath href="#mp2"/></animateMotion></circle>
    <circle r="2" fill="#5B7EC9" fill-opacity=".5"><animateMotion dur="4s" repeatCount="indefinite" begin="1.4s"><mpath href="#mp2"/></animateMotion></circle>
    <g class="df df3" transform="translate(178,476)">
      <rect width="22" height="22" rx="5" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".2" stroke-width=".8"/>
      <path d="M4 11L18 11M12 5L18 11L12 17" stroke="#5B7EC9" stroke-opacity=".52" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"/>
    </g>
    <g class="df df4" transform="translate(120,828)">
      <rect width="22" height="22" rx="5" fill="#5B7EC9" fill-opacity=".1" stroke="#5B7EC9" stroke-opacity=".17" stroke-width=".8"/>
      <path d="M18 11L4 11M10 5L4 11L10 17" stroke="#5B7EC9" stroke-opacity=".48" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"/>
    </g>
  </svg>
</div>

<!-- Ticker -->
<div class="tick" aria-hidden="true">
  <div class="tick-inner">
    <span class="ti">Send Money Instantly</span><span class="ts"> &bull; </span><span class="ti">Split Bills Effortlessly</span><span class="ts"> &bull; </span><span class="ti">Bank-Grade Security</span><span class="ts"> &bull; </span><span class="ti">Zero Hidden Fees</span><span class="ts"> &bull; </span><span class="ti">Real-Time Alerts</span><span class="ts"> &bull; </span><span class="ti">Smart Budgeting</span><span class="ts"> &bull; </span><span class="ti">Global Transfers</span><span class="ts"> &bull; </span><span class="ti">Built for People</span><span class="ts"> &bull; </span><span class="ti">Send Money Instantly</span><span class="ts"> &bull; </span><span class="ti">Split Bills Effortlessly</span><span class="ts"> &bull; </span><span class="ti">Bank-Grade Security</span><span class="ts"> &bull; </span><span class="ti">Zero Hidden Fees</span><span class="ts"> &bull; </span><span class="ti">Real-Time Alerts</span><span class="ts"> &bull; </span><span class="ti">Smart Budgeting</span><span class="ts"> &bull; </span><span class="ti">Global Transfers</span><span class="ts"> &bull; </span><span class="ti">Built for People</span><span class="ts"> &bull; </span>
  </div>
</div>

<!-- Nav -->
<nav>
  <a class="logo" href="#">
    <div class="lm">
      <svg viewBox="0 0 24 24"><path d="M20 4H4C2.89 4 2 4.89 2 6v12c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V6c0-1.11-.89-2-2-2zm0 14H4v-6h16v6zm0-10H4V6h16v2z"/></svg>
    </div>
    <span class="lt">Secure<em>Pay</em></span>
  </a>
  <div class="nb"><div class="ld"></div>Early Access</div>
</nav>

<!-- Hero -->
<section class="hero">
  <div class="hi">
    <div class="bw">
      <div class="bl"><div class="bld"></div>Coming Soon</div>
    </div>
    <h1>
      <span class="ld2">Your money,</span>
      <span class="la">your rules.</span>
    </h1>
    <p class="hd">Next-generation fintech — faster payments, smarter savings.</p>
    <div class="pr">
      <div class="pill">
        <svg fill="var(--a)" viewBox="0 0 24 24"><path d="M7 2v11h3v9l7-12h-4l4-8z"/></svg>Instant Transfers
      </div>
      <div class="pill">
        <svg fill="var(--a)" viewBox="0 0 24 24"><path d="M12 1L3 5v6c0 5.5 3.8 10.7 9 12 5.2-1.3 9-6.5 9-12V5L12 1zm-1 14l-3-3 1.41-1.41L11 12.17l4.59-4.58L17 9l-6 6z"/></svg>Bank-Grade Security
      </div>
      <div class="pill">
        <svg fill="none" stroke="var(--a)" stroke-width="2" stroke-linecap="round" viewBox="0 0 24 24"><circle cx="8.5" cy="8.5" r="2.5"/><circle cx="15.5" cy="15.5" r="2.5"/><line x1="19" y1="5" x2="5" y2="19"/></svg>Zero Hidden Fees
      </div>
    </div>
  </div>
</section>

<!-- Footer -->
<div class="foot">
  <span class="foot-copy">&copy; 2026 SecurePay Inc.</span>
  <div class="fl">
    <a class="fla" href="#">Privacy</a>
    <a class="fla" href="#">Terms</a>
    <a class="fla" href="#">Contact</a>
  </div>
</div>
</body>
</html>
EOF

# Owner = ec2-user (bisa edit), group = apache (Apache bisa baca)
chown ec2-user:apache /var/www/html/index.html

# Permission: owner baca/tulis, group baca, others baca
chmod 664 /var/www/html/index.html

# Direktori: owner & group bisa masuk dan baca
chown ec2-user:apache /var/www/html
chmod 775 /var/www/html
