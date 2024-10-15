import SwiftUI

@MainActor
struct CompositionRoot {
    var rootView: some View {
        RouterView(
            screenProvider: ScreenProviderComposer.compose(),
            screenMapper: ScreenMapperComposer.compose()
        )
    }
}
