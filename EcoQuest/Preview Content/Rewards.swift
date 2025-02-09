import SwiftUI

struct Rewards: View {
    @State private var availableXP: Int = 500 // Example: Available XP
    @State private var claimedRewards: [String] = [] // Store claimed rewards

    let rewardsSections: [RewardSection] = [
        RewardSection(title: "Exclusive Merchandise", rewards: [
            Reward(title: "EcoQuest Hoodie", points: 500, description: "A cozy hoodie with the EcoQuest logo.", image: "hoodie"),
            Reward(title: "EcoQuest Water Bottle", points: 300, description: "A stainless steel water bottle.", image: "bottle"),
        ]),
        RewardSection(title: "Achievements", rewards: [
            Reward(title: "Eco Warrior Badge", points: 100, description: "An achievement badge for eco-friendly quests.", image: "badge"),
            Reward(title: "Master Recycler Pin", points: 150, description: "A pin to honor your recycling efforts.", image: "pin"),
        ])
    ]

    var body: some View {
        VStack(spacing: 20) {
            // Header with available XP
            VStack {
                Text("Your Rewards")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Text("Available XP: \(availableXP)")
                    .font(.headline)
                    .foregroundColor(.blue)
            }

            // Divider
            Divider()
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
                .padding(.horizontal)
            }

            Spacer()
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
                .font(.title2)
                .fontWeight(.bold)

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
            Image(systemName: reward.image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .background(Color(.systemGray6))
                .cornerRadius(10)

            VStack(alignment: .leading) {
                // Reward Title and Description
                Text(reward.title)
                    .font(.headline)
                Text(reward.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("\(reward.points) XP")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }

            Spacer()

            if claimedRewards.contains(reward.title) {
                Text("Claimed")
                    .font(.subheadline)
                    .foregroundColor(.green)
                    .padding(8)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
            } else {
                Button(action: {
                    claimReward(reward)
                }) {
                    Text("Claim")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(availableXP >= reward.points ? Color.blue : Color.gray)
                        .cornerRadius(10)
                }
                .disabled(availableXP < reward.points)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
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
