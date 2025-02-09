import SwiftUI

struct Rewards: View {
    @State private var availableXP: Int = 500 // Example: Available XP
    @State private var claimedRewards: [String] = [] // Store claimed rewards

    let rewardsSections: [RewardSection] = [
        RewardSection(title: "Exclusive Merchandise", rewards: [
            Reward(title: "NC State Hoodie", points: 500, description: "A cozy hoodie with the NC State logo.", image: "hoodie"),
            Reward(title: "NC State Water Bottle", points: 300, description: "A stainless steel water bottle.", image: "bottle"),
        ]),
        RewardSection(title: "Achievements", rewards: [
            Reward(title: "Eco Warrior Badge", points: 100, description: "An achievement badge for eco-friendly quests.", image: "badge"),
            Reward(title: "Master Spin Biker", points: 150, description: "A pin to honor your use of bikes.", image: "pin"),
        ])
    ]

    var body: some View {
        ZStack {
            Color(red: 0.88, green: 0.95, blue: 1.0) // Light blue to match EcoQuest
                            .ignoresSafeArea()
            // Foreground Content
            VStack(spacing: 20) {
                // Header with available XP
                VStack(spacing: 10) {
                    Text("Your Rewards")
                        .font(.custom("Marker Felt", size: 30)) // Match EcoQuest font
                        .foregroundColor(.blue)
                        .padding(.top, 40)

                    Text("Available XP: \(availableXP)")
                        .font(.custom("Marker Felt", size: 18))
                        .foregroundColor(.black)
                }

                // Divider
                Divider()
                    .background(Color.blue)
                    .padding(.horizontal)

                // Scrollable Rewards Sections
                ScrollView {
                    VStack(spacing: 30) {
                        ForEach(rewardsSections) { section in
                            RewardsSectionView(
                                section: section,
                                availableXP: $availableXP,
                                claimedRewards: $claimedRewards
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                }

                Spacer()
            }
        }
        .navigationTitle("Rewards")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RewardsSectionView: View {
    let section: RewardSection
    @Binding var availableXP: Int
    @Binding var claimedRewards: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(section.title)
                .font(.custom("Marker Felt", size: 22))
                .foregroundColor(.blue)

            ForEach(section.rewards) { reward in
                RewardItemView(
                    reward: reward,
                    availableXP: $availableXP,
                    claimedRewards: $claimedRewards
                )
            }
        }
    }
}

struct RewardItemView: View {
    let reward: Reward
    @Binding var availableXP: Int
    @Binding var claimedRewards: [String]

    var body: some View {
        HStack(spacing: 15) {
            // Reward Image
            Image(reward.image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)

            VStack(alignment: .leading) {
                // Reward Title and Description
                Text(reward.title)
                    .font(.custom("Marker Felt", size: 18))
                    .foregroundColor(.black)

                Text(reward.description)
                    .font(.custom("Marker Felt", size: 14))
                    .foregroundColor(.gray)

                Text("\(reward.points) XP")
                    .font(.custom("Marker Felt", size: 16))
                    .foregroundColor(.blue)
            }

            Spacer()

            if claimedRewards.contains(reward.title) {
                Text("Claimed")
                    .font(.custom("Marker Felt", size: 14))
                    .foregroundColor(.green)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(10)
            } else {
                Button(action: {
                    claimReward(reward)
                }) {
                    Text("Claim")
                        .font(.custom("Marker Felt", size: 14))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(availableXP >= reward.points ? Color.blue : Color.gray)
                        .cornerRadius(10)
                }
                .disabled(availableXP < reward.points)
            }
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(15)
        .shadow(radius: 5)
    }

    private func claimReward(_ reward: Reward) {
        if availableXP >= reward.points {
            availableXP -= reward.points
            claimedRewards.append(reward.title)
        }
    }
}

// Data Model for Rewards
struct Reward: Identifiable {
    let id = UUID()
    let title: String
    let points: Int
    let description: String
    let image: String
}

struct RewardSection: Identifiable {
    let id = UUID()
    let title: String
    let rewards: [Reward]
}

// Preview
#Preview {
    NavigationView {
        Rewards()
    }
}
