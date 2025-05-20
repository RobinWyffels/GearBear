//
//  FocussedSkiView.swift
//  GearBear
//
//  Created by Robin Wyffels on 20/05/2025.
//

import SwiftUI

struct FocussedSkiView: View {
    @ObservedObject var viewModel: FocussedSkiViewModel
    @Environment(\.dismiss) private var dismiss
    var onScheduleJob: () -> Void
    var qrAction: () -> Void = {}

    @State private var selectedJobId: Int? = nil


    var body: some View {
        PageWithNavBar(
            qrAction: qrAction 
        ) {
            VStack {
                TopBannerView(showBackArrow: true, onBack: { dismiss() })

                ScrollView {
                    HStack {
                        if let brand = viewModel.ski.brand {
                            Image(brand)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 60)
                            Spacer()
                            Text("\(viewModel.athlete.name) - \(viewModel.ski.type ?? "Unknown") \(viewModel.ski.pairNr.map { "\($0)" } ?? "-")")
                                .font(.title)
                                .bold()
                                .foregroundColor(Color.PrimaryText)
                        }
                        Spacer()
                    }
                    .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    VStack{
                            Text("Details")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(Color.PrimaryText)
                                .padding(.bottom, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                

                            let ski = viewModel.ski 
                            VStack(alignment: .leading, spacing: 16) {
                                SkiDetailRow(title: "Brand", value: ski.brand ?? "-")
                                SkiDetailRow(title: "Type", value: ski.type ?? "-")
                                SkiDetailRow(title: "Numeber", value: ski.pairNr != nil ? "\(ski.pairNr!)" : "-")
                                .padding(.bottom, 8)
                                
                                SkiDetailRow(title: "Length", value: ski.length != nil ? "\(ski.length!) cm" : "- cm")
                                SkiDetailRow(title: "Radius", value: ski.radius != nil ? "\(ski.radius!) m" : "- m")
                                .padding(.bottom, 8)

                                SkiDetailRow(title: "Year", value: ski.year ?? "-")
                                SkiDetailRow(title: "First Use", value: ski.firstUse ?? "-")
                                .padding(.bottom, 8)

                                SkiDetailRow(title: "Model #", value: ski.modelNr ?? "-")
                                SkiDetailRow(title: "Factory Id", value: "\(ski.id)")                                    
                                .padding(.bottom, 8)
                                
                                SkiDetailRow(title: "Binding", value: ski.binding ?? "-")
                                SkiDetailRow(title: "Front Lift", value: ski.frontLift != nil ? "\(ski.frontLift!) mm" : "- mm")
                                SkiDetailRow(title: "Back Lift", value: ski.backLift != nil ? "\(ski.backLift!) mm" : "- mm")
                                SkiDetailRow(title: "Front Total", value: ski.frontTotal != nil ? "\(ski.frontTotal!) mm" : "- mm")
                                SkiDetailRow(title: "Back Total", value: ski.backTotal != nil ? "\(ski.backTotal!) mm" : "- mm")
                                SkiDetailRow(title: "TTFB", value: ski.tipToFrontBinding != nil ? "\(ski.tipToFrontBinding!) mm" : "- mm")
                                .padding(.bottom, 8)
                                
                                SkiDetailRow(title: "QR Code Nr", value: ski.qrCodeNr ?? "-")
                            }
                            .padding(.horizontal)
                            
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)

                    // Linked Jobs Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Jobs")
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color.PrimaryText)
                            .padding(.top, 20)
                            .padding(.horizontal)

                        if viewModel.jobCards.isEmpty {
                            Text("No jobs for this ski.")
                                .foregroundColor(Color.PrimaryText)
                                .padding(.horizontal)
                        } else {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.jobCards) { job in
                                    JobCardView(job: job) {
                                        selectedJobId = job.id
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    Button("Schedule New Job") {
                        onScheduleJob()
                    }
                    .padding()
                    .background(Color.MainAppColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                }
                .navigationDestination(item: $selectedJobId) { jobId in
                    JobDetailView(jobId: jobId, showScheduleJob: .constant(false))
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }
}
