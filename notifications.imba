export const timeout = do(ms) return new Promise(do(resolve) setTimeout(resolve, ms))

export class Notifications
	duration = {
		show: 500
		display: 15000
		hide: 500
		wipe: 500
		expand: 200
	}
	counter = 0
	queue = []
	hint = ''
	keys = {header:'header', text:'text'}
	
	def fire id, type, header, text, details
		const notification = 
			id: id
			type: type
			header: header
			text: text
			details: details
			state: 'show'
			clicked: false
			hide: do 
				this.state = 'hide'
				imba.commit!
				await timeout(duration.hide)
				this.state = 'wipe'
				imba.commit!
				await timeout(duration.wipe)
				queue = [] if !queue.filter(do(n) n.state != 'wipe').length
				imba.commit!
			click: do
				this.clicked = true if this.state == 'display'

		queue.push notification
		await timeout(duration.show)
		notification.state = 'display'
		imba.commit!
		await timeout(duration.display)
		notification.hide! if notification.state == 'display' and !notification.clicked
		
	def success message\Object, details = ''
		if message isa Object and message[keys.header]
			fire ++counter, 0, message[keys.header], message[keys.text], details

	def info message\Object, details = ''
		if message isa Object and message[keys.header]
			fire ++counter, 1, message[keys.header], message[keys.text], details

	def caution message\Object, details = ''
		if message isa Object and message[keys.header]
			fire ++counter, 2, message[keys.header], message[keys.text], details

	def error message\Object, details = ''
		if message isa Object and message[keys.header]
			fire ++counter, 3, message[keys.header], message[keys.text], details
	
# --------------------------------------------------
# Icons
# --------------------------------------------------
tag IconSuccess 
	<self><svg viewBox="0 0 256 256"><path d="M173.66,98.34a8,8,0,0,1,0,11.32l-56,56a8,8,0,0,1-11.32,0l-24-24a8,8,0,0,1,11.32-11.32L112,148.69l50.34-50.35A8,8,0,0,1,173.66,98.34ZM232,128A104,104,0,1,1,128,24,104.11,104.11,0,0,1,232,128Zm-16,0a88,88,0,1,0-88,88A88.1,88.1,0,0,0,216,128Z">
tag IconInfo
	<self><svg viewBox="0 0 256 256"><path d="M128,24A104,104,0,1,0,232,128,104.11,104.11,0,0,0,128,24Zm0,192a88,88,0,1,1,88-88A88.1,88.1,0,0,1,128,216Zm16-40a8,8,0,0,1-8,8,16,16,0,0,1-16-16V128a8,8,0,0,1,0-16,16,16,0,0,1,16,16v40A8,8,0,0,1,144,176ZM112,84a12,12,0,1,1,12,12A12,12,0,0,1,112,84Z">
tag IconCaution
	<self><svg viewBox="0 0 256 256"><path d="M236.8,188.09,149.35,36.22h0a24.76,24.76,0,0,0-42.7,0L19.2,188.09a23.51,23.51,0,0,0,0,23.72A24.35,24.35,0,0,0,40.55,224h174.9a24.35,24.35,0,0,0,21.33-12.19A23.51,23.51,0,0,0,236.8,188.09ZM222.93,203.8a8.5,8.5,0,0,1-7.48,4.2H40.55a8.5,8.5,0,0,1-7.48-4.2,7.59,7.59,0,0,1,0-7.72L120.52,44.21a8.75,8.75,0,0,1,15,0l87.45,151.87A7.59,7.59,0,0,1,222.93,203.8ZM120,144V104a8,8,0,0,1,16,0v40a8,8,0,0,1-16,0Zm20,36a12,12,0,1,1-12-12A12,12,0,0,1,140,180Z">
tag IconError
	<self><svg viewBox="0 0 256 256"><path d="M165.66,101.66,139.31,128l26.35,26.34a8,8,0,0,1-11.32,11.32L128,139.31l-26.34,26.35a8,8,0,0,1-11.32-11.32L116.69,128,90.34,101.66a8,8,0,0,1,11.32-11.32L128,116.69l26.34-26.35a8,8,0,0,1,11.32,11.32ZM232,128A104,104,0,1,1,128,24,104.11,104.11,0,0,1,232,128Zm-16,0a88,88,0,1,0-88,88A88.1,88.1,0,0,0,216,128Z">
tag IconClose
	<self><svg viewBox="0 0 256 256"><path d="M205.66,194.34a8,8,0,0,1-11.32,11.32L128,139.31,61.66,205.66a8,8,0,0,1-11.32-11.32L116.69,128,50.34,61.66A8,8,0,0,1,61.66,50.34L128,116.69l66.34-66.35a8,8,0,0,1,11.32,11.32L139.31,128Z">

tag icon-success < IconSuccess
tag icon-info < IconInfo
tag icon-caution < IconCaution
tag icon-error < IconError
tag icon-close < IconClose

# --------------------------------------------------
# Visual component to display notifications
# --------------------------------------------------
tag notification-center
	state
	icons = [IconSuccess, IconInfo, IconCaution, IconError, IconClose]
	type = ['success', 'info', 'caution', 'error']

	def mount
		console.log 'No state defined for <notifications-center>' if !state

		style.setProperty("--show", "{state.duration.show || 500}ms")
		style.setProperty("--display", "{state.duration.display || 15000}ms")
		style.setProperty("--hide", "{state.duration.hide || 500}ms")
		style.setProperty("--wipe", "{state.duration.wipe || 500}ms")
		style.setProperty("--expand", "{state.duration.expand || 200}ms")

	css
		.notification
			pos:rel
			d:grid tween:grid-template-rows var(--wipe) ease
			pe:auto cursor:default
			mt:10px mr:10px rd:5px
			backdrop-filter: blur(20px)
			bgc:light-dark(black/8, white/10)
			bd:1px solid light-dark(black/16, white/20)
		.header 
			d:hcc m:10px
		.icon 
			w:24px
			@.success fill:light-dark(#1b9023,#61e16a)
			@.info fill:light-dark(#0b46b3,#49bfff)
			@.caution fill:light-dark(#cf9400,#faff5b)
			@.error fill:light-dark(#ac0000,#ff3b1d)
		.title 
			ml:10px 
			fs:15px fw:normal 
			c:light-dark(black, white)
		.close 
			ml:auto w:26px h:26px p:5px rd:4px 
			cursor:pointer 
			fill:light-dark(black, white) 
			bgc@hover:light-dark(black/20, white/20)
		.content
			d:grid tween:grid-template-rows var(--expand) ease
			ml:44px mr:36px
		.text 
			fs:12px fw:normal 
			c:light-dark(black/80, white/60)
		.details 
			w:100% mt:15px p:10px rd:4px
			bgc:light-dark(black/5, white/10) 
			fs:11px fw:normal
			c:light-dark(black, white/90)
			overflow-wrap:break-word word-wrap:break-word ws:normal
		.footer
			mb:15px
		.timer 
			pos:rel 
			px:10px py:2px w:100% ta:center
			fs:11px fw:normal ws:nowrap of:hidden tof:ellipsis
			c:light-dark(black/70, white/70)
			bgc:light-dark(black/5, white/10)
			@before
				content: ''
				pos:abs h:100% t:0 l:0
				bgc:light-dark(black/5, white/10)
				animation: progress calc(var(--show) + var(--display)) linear forwards
				@keyframes progress
					from w:0%
					to w:100%

		.show
			gtr: 1fr
			animation: show var(--show) ease
			@keyframes show	
				from transform: translateX(100%)
		.hide
			gtr: 1fr
			animation: hide var(--hide) ease forwards
			@keyframes hide
				to transform: translateX(100%) mr:0px
		.wipe
			transform: translateX(100%) mr:0px
			gtr: 0fr 
			animation: wipe var(--wipe) ease forwards
			@keyframes wipe
				to my:0 py:0 bd:0px

	<self [bgc:transparent h:100vh pe:none d:vflex zi:10000 pos:fixed r:0]>
		for notification in state.queue
			<div.notification .{notification.state} @click=notification.click>
				<div.wrapper [of:hidden d:vflex]>
					<div.header>
						<{icons[notification.type]}.icon .{type[notification.type]}>
						<div.title> notification.header
						<{icons[4]}.close @click.trap=notification.hide>
					<div.content [gtr:1fr]=notification.clicked [gtr:0fr]=!notification.clicked>
						<div.wrapper [of:hidden]>
							<div.text> notification.text
							if notification.details
								<div.details> notification.details
							<div.footer>
					if !notification.clicked
						<div.timer [py@off:0px my@off:0px h@off:0px ead:var(--expand)] ease> state.hint