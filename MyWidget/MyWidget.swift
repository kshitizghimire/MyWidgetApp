import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
	func placeholder(in _: Context) -> SimpleEntry {
		SimpleEntry(date: Date())
	}

	func getSnapshot(in _: Context, completion: @escaping (SimpleEntry) -> Void) {
		let entry = SimpleEntry(date: Date())
		completion(entry)
	}

	func getTimeline(in _: Context, completion: @escaping (Timeline<Entry>) -> Void) {
		print("refresh")
		var entries: [SimpleEntry] = []

		let currentDate = Date()
		for offset in 0 ..< 10 {
			let entryDate = Calendar.current.date(byAdding: .second, value: offset, to: currentDate)!
			let entry = SimpleEntry(date: entryDate)
			entries.append(entry)
		}

		let timeline = Timeline(entries: entries, policy: .never)
		completion(timeline)
	}
}

struct SimpleEntry: TimelineEntry {
	let date: Date
}

struct MyWidgetEntryView: View {
	@Environment(\.widgetFamily) var widgetFamily

	var entry: Provider.Entry

	var body: some View {
		ZStack {
			LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing)
			Text(entry.date, style: .time)
				.foregroundColor(.white)
				.font(.title)
				.fontWeight(.bold)
				.padding()
				.background(Color.random)
		}
	}
}

@main
struct MyWidget: Widget {
	let kind: String = "MyWidget"

	var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: Provider()) { entry in
			MyWidgetEntryView(entry: entry)
		}
		.configurationDisplayName("My Widget")
		.description("This is an example widget.")
	}
}

struct MyWidget_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			MyWidgetEntryView(entry: SimpleEntry(date: Date()))
				.previewContext(WidgetPreviewContext(family: .systemSmall))
			MyWidgetEntryView(entry: SimpleEntry(date: Date()))
				.previewContext(WidgetPreviewContext(family: .systemMedium))
			MyWidgetEntryView(entry: SimpleEntry(date: Date()))
				.previewContext(WidgetPreviewContext(family: .systemLarge))
		}
	}
}

extension Color {
	static var random: Color {
		Color(
			red: .random(in: 0 ... 1),
			green: .random(in: 0 ... 1),
			blue: .random(in: 0 ... 1)
		)
	}
}
