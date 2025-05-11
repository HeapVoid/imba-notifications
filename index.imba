export const timeout = do(ms) return new Promise(do(resolve) setTimeout(resolve, ms))

export class Notifications
	duration = {
		show: 500
		display: 15000
		hide: 500
		wipe: 500
	}
	counter = 0
	queue = []
	hint = ''
	commit = undefined
	
	def constructor commit
		if !commit
			console.log 'Pass imba.commit function to the <Notifications> constructor'
		commit = commit

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
				commit! if commit isa Function
				await timeout(duration.hide)
				this.state = 'wipe'
				commit! if commit isa Function
				await timeout(duration.wipe)
				queue = [] if !queue.filter(do(n) n.state != 'wipe').length
				commit! if commit isa Function
			click: do
				this.clicked = true if this.state == 'display'

		queue.push notification
		await timeout(duration.show)
		notification.state = 'display'
		commit! if commit isa Function
		await timeout(duration.display)
		notification.hide! if notification.state == 'display' and !notification.clicked
		
	def success header\string, text\string, details = ''
		fire ++counter, 0, header, text, details

	def info header\string, text\string, details = ''
		fire ++counter, 1, header, text, details

	def caution header\string, text\string, details = ''
		fire ++counter, 2, header, text, details

	def error header\string, text\string, details = ''
		fire ++counter, 3, header, text, details
	

